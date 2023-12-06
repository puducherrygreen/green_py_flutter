import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_puducherry/constant/firebase_exception.dart';
import 'package:green_puducherry/constant/green_text.dart';
import 'package:green_puducherry/helpers/local_storage.dart';
import 'package:green_puducherry/models/region_model.dart';
import 'package:green_puducherry/models/user_model.dart';
import 'package:green_puducherry/screens/auth/pages/profile_information.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:velocity_x/velocity_x.dart';

import '../helpers/my_navigation.dart';
import '../models/commune_model.dart';
import '../screens/home/pages/home.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  final AuthService _authService = AuthService();
  bool letsStart = false;
  bool isPending = true;

  UserModel? userModel;
  List<RegionModel> allRegion = [];
  List<CommuneModel> allCommune = [];
  RegionModel? regionModel;
  CommuneModel? communeModel;
  bool communeState = false;
  AuthProvider() {
    getCurrentUser();
    getLocalUser();
    notifyListeners();

    print("auth provider : $user");
    print("auth provider : ${user?.email}");
  }
  getCurrentUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  Future<dynamic> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    final data =
        await _authService.signupWithEmail(email: email, password: password);
    if (data == null) {
      return MyFirebaseException.kUserExist;
    }
    user = data;

    notifyListeners();
    return data;
  }

  Future<UserModel?> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    UserModel? uModel =
        await _authService.loginWithEmail(email: email, password: password);

    userModel = uModel;
    notifyListeners();
    return uModel;
  }

  Future<dynamic> googleOauth(BuildContext context) async {
    try {
      print('auth provider oauth start =========================');
      final data = await _authService.googleOAuth(context);
      print('auth provider oauth end =========================');
      print("Google O Auth : $data");
      if (data != null) {
        userModel = data;
        bool showcaseHidden =
            await LocalStorage.getBool(GreenText.kShowcase) ?? false;
        notifyListeners();
        if (context.mounted) {
          MyNavigation.to(
            context,
            ShowCaseWidget(
              builder: Builder(
                builder: (context) => Home(
                  showcaseHidden: showcaseHidden,
                ),
              ),
            ),
          );
        }
      }
      if (data == null) {
        return null;
      }
      getCurrentUser();
    } catch (e) {
      print('auth provider oauth error =========================');
      print(e);
      print('auth provider oauth error =========================');
    }
  }

  getLocalUser() async {
    Map? uData = await LocalStorage.getMap('userData');
    if (uData != null) {
      Map<String, dynamic> userModelData = uData.cast<String, dynamic>();
      print(userModelData);
      userModel = UserModel.fromJson(userModelData);
      await LocalStorage.setString(GreenText.kUserId, userModel!.id);
    } else {
      User? lUser = FirebaseAuth.instance.currentUser;
      if (lUser != null) {
        userModel = await _authService.apiLogin(email: "${lUser.email}");
      }
    }
    notifyListeners();
  }

  logout() async {
    await _authService.logout();
    user = _authService.getCurrentUser();
    LocalStorage.clear();
    notifyListeners();
  }

  Future<String> sendEmailVerification(BuildContext context) async {
    return await _authService.sendEmailVerification().then((status) {
      if (status == GreenText.kTooManyRequests) {
        VxToast.show(context, msg: GreenText.kTooManyRequests);
      }
      return status;
    });
  }

  forgetPassword({required String email}) async {
    String msg = await _authService.forgetPassword(email: email);
    return msg;
  }

  static verificationTimer(BuildContext context) async {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        LocalStorage.setBool(GreenText.kIsLogged, true);
        await LocalStorage.setBool(GreenText.kIsPending, true);
        timer.cancel();
        if (context.mounted) {
          MyNavigation.replace(context, const ProfileInformation());
        }
      }
    });
  }

  getRegion() async {
    try {
      List<dynamic> mapRegion = await _authService.getAllRegion();
      List<RegionModel> tempRegion = mapRegion.map((e) {
        return RegionModel.fromJson(e);
      }).toList();
      allRegion = tempRegion;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  changeRegion({required String regionName}) async {
    for (RegionModel i in allRegion) {
      if (i.regionName == regionName) {
        regionModel = i;
        await getCommuneWithRegionId(regionId: i.id);
        return;
      }
    }
  }

  changeCommune({required String communeName}) async {
    for (CommuneModel i in allCommune) {
      if (i.communeName == communeName) {
        communeModel = i;
        notifyListeners();
        return;
      }
    }
  }

  changeCommuneState({bool? state}) {
    if (state != null) {
      communeState = state;
    } else {
      communeState = !communeState;
    }
    notifyListeners();
  }

  getCommuneWithRegionId({required String regionId}) async {
    try {
      List<dynamic> mapCommune =
          await _authService.getAllCommune(regionId: regionId);
      List<CommuneModel> tempCommune = mapCommune.map((e) {
        return CommuneModel.fromJson(e);
      }).toList();

      allCommune = tempCommune;
      changeCommuneState(state: true);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  registerUser({required Map<String, dynamic> userInfo}) async {
    await _authService.registerUser(userInfo: userInfo);
    getLocalUser();
  }
}
