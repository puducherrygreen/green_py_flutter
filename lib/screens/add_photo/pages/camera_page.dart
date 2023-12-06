import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';

import '../../../main.dart';
import 'photo_info_page.dart';

/// CameraApp is the Main Application.
class CameraPage extends StatefulWidget {
  /// Default Constructor
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;

  bool snaped = false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(kGlobalCamera[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            print("camera access denied-------------------Error");
            break;
          default:
            // Handle other errors here.
            print("camera other-------------------Error");
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  dynamic takePhoto() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    if (controller.value.isTakingPicture) {
      return null;
    }
    try {
      setState(() {
        snaped = true;
      });

      await controller.setFlashMode(FlashMode.auto);
      XFile file = await controller.takePicture();

      print("file----------------------------$file");
      if (context.mounted) {
        MyNavigation.replace(
            context,
            PhotoInfoPage(
              file: file,
            ));
      }
    } on CameraException catch (e) {
      print("Error occured while taking pictur-------------------Error");
      print("Error occured while taking picture : $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 1.sh,
          color: Colors.grey[200],
          child: CameraPreview(controller),
        ),
        Positioned(
          bottom: 20.h,
          width: 1.sw,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: takePhoto,
                child: Container(
                  height: 60.w,
                  width: 60.w,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(35.w)),
                  child: Container(
                    height: 60.w,
                    width: 60.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.w)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 0.9.sw,
          width: 0.9.sw,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child:
                snaped ? const CircularProgressIndicator() : const SizedBox(),
          ),
        ),
      ],
    );
  }
}
