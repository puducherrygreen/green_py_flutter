import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/helpers/validation_helper.dart';
import 'package:green_puducherry/screens/auth/widgets/green_puducherry.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../home/pages/home.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({super.key});

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  final TextEditingController fullName = TextEditingController();

  final TextEditingController mobileNumber = TextEditingController();

  final TextEditingController address = TextEditingController();

  final TextEditingController pinCode = TextEditingController();

  final TextEditingController region = TextEditingController();

  final TextEditingController commune = TextEditingController();

  clearFields() {
    fullName.clear();
    mobileNumber.clear();
    address.clear();
    pinCode.clear();
    region.clear();
    commune.clear();
  }

  bool nameValidate = true;
  bool numberValidate = true;
  bool addressValidate = true;
  bool pinCodeValidate = true;
  bool regionValidate = true;
  bool communeValidate = true;

  bool loading = false;

  validateAll() {
    nameValidate = ValidationHelper.nameValidation(value: fullName.text.trim());
    communeValidate =
        ValidationHelper.nameValidation(value: commune.text.trim());
    regionValidate = ValidationHelper.nameValidation(value: region.text.trim());
    numberValidate = ValidationHelper.mobileNumberValidation(
        value: mobileNumber.text.trim());
    addressValidate =
        ValidationHelper.addressValidation(value: address.text.trim());
    pinCodeValidate =
        ValidationHelper.pincodeValidation(value: pinCode.text.trim());
    setState(() {});
    return nameValidate &&
        communeValidate &&
        regionValidate &&
        numberValidate &&
        addressValidate &&
        pinCodeValidate;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRegion();
  }

  getRegion() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.getRegion();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return BackgroundScaffold(
      loading: loading,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GreenPuducherry(),
              const GText('Profile Information'),
              SizedBox(height: 10.h),
              MyTextField(
                isValid: nameValidate,
                controller: fullName,
                isPassword: false,
                hintText: "Full Name",
                errorText: "Invalid Full Name",
                onChange: (val) {
                  nameValidate = true;
                  setState(() {});
                },
              ),
              SizedBox(height: 10.h),
              MyTextField(
                isValid: numberValidate,
                controller: mobileNumber,
                isPassword: false,
                hintText: "Mobile Number",
                errorText: "Invalid Mobile Number",
                keyboardType: TextInputType.phone,
                onChange: (val) {
                  numberValidate = true;
                  setState(() {});
                },
              ),
              SizedBox(height: 10.h),
              MyTextField(
                isValid: addressValidate,
                controller: address,
                isPassword: false,
                hintText: "Address",
                errorText: "Invalid Address",
                keyboardType: TextInputType.multiline,
                onChange: (val) {
                  addressValidate = true;
                  setState(() {});
                },
              ),
              SizedBox(height: 10.h),
              MyTextField(
                isValid: pinCodeValidate,
                controller: pinCode,
                isPassword: false,
                hintText: "Pin Code",
                errorText: "Invalid Pin Code",
                keyboardType: TextInputType.number,
                onChange: (val) {
                  pinCodeValidate = true;
                  setState(() {});
                },
              ),
              SizedBox(height: 10.h),
              MyDropDown(
                border: regionValidate ? null : Colors.red,
                hintText: "Region",
                errorText: "Invalid Region",
                onChange: (value) async {
                  print("Region : $value");
                  region.text = value;
                  commune.clear();
                  authProvider.changeCommuneState(state: false);
                  await authProvider.changeRegion(regionName: value);

                  regionValidate = true;
                  setState(() {});
                },
                items: authProvider.allRegion.map((e) => e.regionName).toList(),
              ),
              SizedBox(height: 10.h),
              authProvider.communeState
                  ? MyDropDown(
                      border: communeValidate ? null : Colors.red,
                      hintText: "Commune/Municipality",
                      errorText: "Invalid Commune/Municipality",
                      value: commune.text.isEmpty ? null : commune.text,
                      onChange: (value) async {
                        print("Commune/Municipality : $value");
                        commune.text = value;
                        await authProvider.changeCommune(communeName: value);
                        communeValidate = true;
                        setState(() {});
                      },
                      items: authProvider.allCommune
                          .map((e) => e.communeName)
                          .toList(),
                    )
                  : const MyDropDown(
                      hintText: "Commune/Municipality",
                      items: [],
                    ),
              SizedBox(height: 10.h),
              GreenButton(
                text: "Submit",
                onPressed: () async {
                  bool validation = validateAll();
                  User? user = FirebaseAuth.instance.currentUser;
                  authProvider.getCurrentUser();

                  print('auth register: $user and validation $validation');
                  if (user != null && validation) {
                    final fcmToken =
                        await FirebaseMessaging.instance.getToken();
                    Map<String, dynamic> profileData = {
                      "email": authProvider.user?.email,
                      "userName": fullName.text.trim(),
                      "mobileNumber": mobileNumber.text,
                      "address": address.text,
                      "pincode": pinCode.text,
                      "regionId": authProvider.regionModel?.id,
                      "communeId": authProvider.communeModel?.id,
                      "deviceToken": fcmToken,
                    };

                    clearFields();
                    try {
                      await authProvider.registerUser(userInfo: profileData);
                      loading = false;
                    } catch (e) {
                      loading = false;
                    }
                    setState(() {});

                    if (context.mounted) {
                      MyNavigation.to(context, Home());
                    }
                  } else {
                    print('some field are missing');
                  }
                },
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
