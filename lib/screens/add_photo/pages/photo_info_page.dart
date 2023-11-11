import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/helpers/image_helper.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/providers/auth_provider.dart';
import 'package:green_puducherry/screens/add_photo/pages/camera_page.dart';
import 'package:green_puducherry/screens/add_photo/pages/photo_added_messege.dart';
import 'package:green_puducherry/screens/home/pages/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common_widgets/image_info_tail.dart';
import '../../../providers/plant_provider.dart';

class PhotoInfoPage extends StatefulWidget {
  const PhotoInfoPage({super.key, this.file, this.imagePath});
  final XFile? file;
  final String? imagePath;

  @override
  State<PhotoInfoPage> createState() => _PhotoInfoPageState();
}

class _PhotoInfoPageState extends State<PhotoInfoPage> {
  String? sampleImageUrl;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<PlantProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return BackgroundScaffold(
        loading: loading,
        appBar: greenAppBar(title: "Plant details"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 0.8.sw,
                    width: 0.8.sw,
                    color: Colors.white,
                    child: widget.file != null
                        ? Image.file(
                            File(widget.file!.path),
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            widget.imagePath ?? GreenImages.kPlanting,
                            fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 5.h),
                ImageInfoTail(
                    fieldName: "Plant Name",
                    value:
                        "${plantProvider.currentPlantModel?.plantName ?? plantProvider.selectedPlantModel?.plantName}"),
                if (plantProvider.location != null)
                  Row(
                    children: [
                      Expanded(
                          child: ImageInfoTail(
                              fieldName: "Latitude",
                              value: "${plantProvider.location?.latitude}")),
                      SizedBox(width: 5.w),
                      Expanded(
                          child: ImageInfoTail(
                              fieldName: "Longitude",
                              value: "${plantProvider.location?.longitude}")),
                    ],
                  ),
                ImageInfoTail(
                    fieldName: "Date", value: plantProvider.getCurrentTime()),
                ImageInfoTail(
                    fieldName: "Status",
                    value: plantProvider.isAlive ? "Alive" : "Dead"),
                SizedBox(height: 10.h),
                GreenButton(
                  text: 'Retake',
                  onPressed: () {
                    MyNavigation.to(context, CameraPage());
                  },
                ),
                SizedBox(height: 5.h),
                GreenButton(
                  text: 'Looks Good Upload',
                  onPressed: () async {
                    loading = true;
                    setState(() {});
                    Map<String, dynamic> plantInfo = {
                      "imageUrl": widget.imagePath,
                      "availablePlantId":
                          plantProvider.currentPlantModel?.availablePlantId ??
                              plantProvider.selectedPlantModel?.id,
                      "userId": authProvider.userModel?.id,
                      "communeId": authProvider.userModel?.communeId,
                      "regionId": authProvider.userModel?.regionId,
                      "latitude": "${plantProvider.location?.latitude}",
                      "longitude": "${plantProvider.location?.longitude}",
                      "status": plantProvider.isAlive ? "Alive" : "Dead",
                      // if (plantProvider.plantModel != null)
                      //   "plantDetailsID": plantProvider.plantModel?.id,
                    };
                    print(plantInfo);
                    try {
                      if (widget.file != null) {
                        await ImageHelper.uploadFile(widget.file!,
                            plantProvider: plantProvider, otherData: plantInfo);
                      } else {
                        print(plantInfo);
                        plantProvider.addPlantPhoto(plantData: plantInfo);
                      }
                      if (context.mounted) {
                        MyNavigation.offAll(context, AddPhotoMessage());
                      }
                    } catch (e) {
                      print("something wrong while plant adding......");
                    }
                    loading = false;
                    setState(() {});
                  },
                ),
                SizedBox(height: 20.h)
              ],
            ),
          ),
        ));
  }
}
