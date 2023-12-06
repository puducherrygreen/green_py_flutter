import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/constant/green_api.dart';
import 'package:green_puducherry/helpers/local_storage.dart';
import 'package:green_puducherry/models/user_model.dart';
import 'package:green_puducherry/screens/auth/pages/profile_information.dart';

import 'package:http/http.dart' as http;

import '../helpers/my_navigation.dart';

class AuthService {
  AuthService() {
    FirebaseAuth.instance.userChanges().listen((event) {
      // print('user listener in auth service-----------------');
      // print(event);
      // print('user listener in auth service-----------------');
    });
  }

  final _auth = FirebaseAuth.instance;

  getCurrentUser() {
    User? user = _auth.currentUser;
    return user;
  }

  Future<User?> signupWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential? data = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('Auth Service $data');
      return data.user;
    } on FirebaseException catch (err) {
      print("Auth Service Error----------${err.code}");
      return null;
    }
  }

  Future<UserModel?> loginWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential? data = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Auth Service $data');

      return await apiLogin(email: email);
    } on FirebaseException catch (err) {
      print("Auth Service Error----------${err.code}");
      return null;
    }
  }

  Future<dynamic> googleOAuth(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final data = await googleSignIn.signIn();
      print('oauth data -------------------- $data');
      if (data == null) return null;
      final gAuth = await data.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      UserCredential crd =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("${data.email}${data.displayName}");

      UserModel? userModel = await apiLogin(email: data.email);
      if (userModel != null) {
        LocalStorage.setBool(GreenText.kIsLogged, true);
        return userModel;
      } else {
        if (context.mounted) {
          MyNavigation.to(context, const ProfileInformation());
        }
      }
      LocalStorage.setBool(GreenText.kIsPending, true);
    } on FirebaseAuthException catch (e) {
      print("Auth service oAuth error--------------");
      print(e);
      print("Auth service oAuth error--------------");
      rethrow;
    }
  }

  logout() async {
    await _auth.signOut();
    LocalStorage.setBool(GreenText.kIsLogged, false);
  }

  Future<String> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
      return GreenText.kSuccessMsg;
    } on FirebaseAuthException catch (e) {
      print('verification sending error--------');
      print(e.code);
      print(e.message);
      print('verification sending error--------');

      return e.code;
    }
  }

  Future<dynamic> forgetPassword({required String email}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: email);
      return GreenText.kSuccessMsg;
    } on FirebaseAuthException catch (e) {
      print("Forget password Error : ${e.code}");
      return e.code;
    }
  }

  ///API methods
  Future<UserModel?> apiLogin({required String email}) async {
    var client = http.Client();
    debugPrint('AIP calling -----------------');
    // final res = await http.get(GreenApi.kBaseUri);
    // print(res.body);
    try {
      final res = await client.post(GreenApi.kLoginUri, body: {"email": email});

      debugPrint(res.body);

      Map<String, dynamic>? userData;
      if (res.statusCode == 200) {
        userData = json.decode(res.body);
        if (userData?['Message'] != null) {
          return null;
        }

        await LocalStorage.setMap(GreenText.kUsername, userData ?? {});
        debugPrint('AIP end -----------------');
        UserModel usermodel = UserModel.fromJson(userData);
        await LocalStorage.setString(GreenText.kUserId, usermodel.id);
        return usermodel;
      }
      return null;
    } on FirebaseException catch (e) {
      debugPrint(' loginApi API Error -----------------');
      debugPrint(e.message);

      debugPrint(' loginApi API Error -----------------');
      return null;
    }
  }

  Future getAllRegion() async {
    var client = http.Client();
    print('region API calling ----------');
    try {
      final res = await client.get(GreenApi.kGetRegionUri);
      final data = jsonDecode(res.body);
      print(data.runtimeType);
      print('region API calling success ----------');

      return data;
    } catch (e) {
      print('region API error ----------');
      return e;
    }
  }

  Future getAllCommune({required String regionId}) async {
    var client = http.Client();
    print('commune API calling ----------');
    try {
      final res = await client.get(Uri.https(GreenApi.kBaseUrl,
          "${GreenApi.kGetCommuneWithRegionIdUrl}$regionId"));
      final data = jsonDecode(res.body);
      print(data.runtimeType);
      print('commune API calling success ----------');
      print(data);
      return data;
    } catch (e) {
      print('commune API error ----------');
      return e;
    }
  }

  Future registerUser({required Map<String, dynamic> userInfo}) async {
    try {
      final client = http.Client();
      final res = await client.post(GreenApi.kCreateUserUri, body: userInfo);
      print(res.body);
      final data = jsonDecode(res.body);
      Map<String, dynamic> convertedData = data;
      LocalStorage.setBool(GreenText.kIsLogged, true);
      LocalStorage.setBool(GreenText.kIsPending, false);
      await LocalStorage.setString(GreenText.kUserId, convertedData['_id']);
      await LocalStorage.setMap('userData', convertedData);
      print('user succesfuly registerd ----------');
      print(convertedData);
      return convertedData;
    } catch (e) {
      print(e);
    }
  }

  updateDeviceToken({required String? token, required String userId}) async {
    final client = http.Client();
    if (token != null) {
      await client.post(GreenApi.kUpdateDeviceToken,
          body: {"deviceToken": token, "userId": userId});
    }
  }
}
