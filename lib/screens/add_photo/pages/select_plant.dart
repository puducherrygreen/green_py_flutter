import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/common_widgets/green_buttons.dart';
import 'package:green_puducherry/common_widgets/image_for_profile.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/helpers/validation_helper.dart';
import 'package:green_puducherry/providers/auth_provider.dart';
import 'package:green_puducherry/providers/plant_provider.dart';
import 'package:green_puducherry/screens/add_photo/pages/camera_page.dart';
import 'package:green_puducherry/screens/add_photo/pages/status_alert.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SelectPlant extends StatefulWidget {
  const SelectPlant({super.key, this.enableDropDown = false});
  final bool enableDropDown;

  @override
  State<SelectPlant> createState() => _SelectPlantState();
}

class _SelectPlantState extends State<SelectPlant> {
  final TextEditingController region = TextEditingController();

  final TextEditingController commune = TextEditingController();

  bool isValid = true;
  bool regionValidate = true;
  bool communeValidate = true;

  bool loading = false;

  getRequest() async {
    final plantProvider = Provider.of<PlantProvider>(context, listen: false);
    final locationStatus = await Permission.location.status;
    final cameraStatus = await Permission.camera.status;
    final micStatus = await Permission.microphone.status;
    final audioStatus = await Permission.audio.status;
    if (!locationStatus.isGranted) {
      await plantProvider.getAllPermissionRequest();
    }
    if (!cameraStatus.isGranted) {
      await plantProvider.getAllPermissionRequest();
    }
    if (!micStatus.isGranted) {
      await plantProvider.getAllPermissionRequest();
    }
    if (!audioStatus.isGranted) {
      await plantProvider.getAllPermissionRequest();
    }
  }

  Widget buildDropDown({required AuthProvider authProvider}) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        MyDropDown(
          border: regionValidate ? null : Colors.red,
          hintText: "Region",
          errorText: "Invalid Region",
          onChange: (value) async {
            loading = true;
            setState(() {});
            print("Region : $value");
            region.text = value;
            commune.clear();
            await authProvider.changeCommuneState(state: false);
            await authProvider.changeRegion(regionName: value);

            regionValidate = true;
            loading = false;
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
                items:
                    authProvider.allCommune.map((e) => e.communeName).toList(),
              )
            : const MyDropDown(
                hintText: "Commune/Municipality",
                items: [],
              ),
        SizedBox(height: 10.h),
      ],
    );
  }

  bool validateAll({required PlantProvider plantProvider}) {
    if (plantProvider.selectedPlantModel == null &&
        plantProvider.currentPlantModel == null) {
      isValid = false;
    }
    communeValidate =
        ValidationHelper.nameValidation(value: commune.text.trim());
    regionValidate = ValidationHelper.nameValidation(value: region.text.trim());

    setState(() {});
    bool drop =
        widget.enableDropDown ? communeValidate && regionValidate : true;
    return isValid && drop;
  }

  myDialogShowStatusDialog(BuildContext context,
      {required PlantProvider plantProvider}) {
    showDialog(
        context: context,
        builder: (context) {
          return StatusAlert();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) => getRequest());
  }

  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<PlantProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return BackgroundScaffold(
      appBar: greenAppBar(leading: const GreenBackButton()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 0.8.sw,
              width: 0.8.sw,
              child: plantProvider.currentPlantModel != null
                  ? Image.asset(GreenImages.kTrees)
                  : Image.asset(GreenImages.kPlanting),
            ),
            // SizedBox(height: 30.h),

            GText(
              plantProvider.currentPlantModel != null
                  ? "Your plant"
                  : "Register Your Plant",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),
            if (widget.enableDropDown)
              buildDropDown(authProvider: authProvider),
            plantProvider.currentPlantModel == null
                ? MyDropDown(
                    border: isValid ? null : Colors.red,
                    hintText: "Select Your Plant",
                    onChange: (value) {
                      plantProvider.getSelectedPlantWithId(plantName: value);
                      isValid = true;
                      setState(() {});
                    },
                    items: plantProvider.availablePlants
                        .map((e) => e.plantName)
                        .toList(),
                  )
                : Column(
                    children: [
                      GreenBox(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GText(
                                "${plantProvider.currentPlantModel?.plantName}"),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: plantProvider
                                .currentPlantModel!.plantImages
                                .map((e) {
                          print(e);
                          return ImageForView(imageModel: e);
                        }).toList()),
                      ),
                      if (plantProvider
                              .currentPlantModel?.updateDateNextPhoto !=
                          null)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Next chance to take a ${plantProvider.currentPlantModel?.plantName} will be on ${plantProvider.currentPlantModel?.updateDateNextPhoto}",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
            const Spacer(),
            GreenButton(
              enabled:
                  plantProvider.currentPlantModel?.nextPhotoEnabled ?? true,
              // enabled: true,

              onPressed: () async {
                final locationStatus = await Permission.location.status;
                final cameraStatus = await Permission.camera.status;

                if (locationStatus.isGranted && cameraStatus.isGranted) {
                  if (plantProvider.currentPlantModel != null) {
                    if (context.mounted) {
                      await myDialogShowStatusDialog(context,
                          plantProvider: plantProvider);
                    }
                    return;
                  }
                  if (context.mounted) {
                    if (validateAll(plantProvider: plantProvider)) {
                      MyNavigation.replace(context, const CameraPage());
                    }
                  }
                } else {
                  if (context.mounted) {
                    VxToast.show(context, msg: "Some permissions denied");
                    // await plantProvider.showPermissionRequestDialog(context);
                  }
                }
              },
              text: plantProvider.currentPlantModel != null
                  ? "Add Photo"
                  : "Take Photo",
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}
