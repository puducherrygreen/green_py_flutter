import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/common_widgets/green_buttons.dart';
import 'package:green_puducherry/common_widgets/image_for_profile.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/providers/plant_provider.dart';
import 'package:green_puducherry/screens/add_photo/pages/camera_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'photo_info_page.dart';

class SelectPlant extends StatefulWidget {
  const SelectPlant({super.key});

  @override
  State<SelectPlant> createState() => _SelectPlantState();
}

class _SelectPlantState extends State<SelectPlant> {
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<PlantProvider>(context);
    return BackgroundScaffold(
      appBar: greenAppBar(leading: GreenBackButton()),
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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),

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
                      )
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
                print(cameraStatus);
                if (locationStatus.isGranted && cameraStatus.isGranted) {
                  if (plantProvider.selectedPlantModel == null &&
                      plantProvider.currentPlantModel == null) {
                    setState(() {
                      isValid = false;
                    });
                    // return;
                  }
                  if (plantProvider.currentPlantModel != null) {
                    if (context.mounted) {
                      await plantProvider.myDialogShowStatusDialog(context,
                          plantProvider: plantProvider);
                    }
                    return;
                  }
                  if (context.mounted) {
                    MyNavigation.to(context, const CameraPage());
                  }
                } else {
                  if (context.mounted) {
                    await plantProvider.showPermissionRequestDialog(context);
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
