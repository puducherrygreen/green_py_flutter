import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/helpers/pop_scope_function.dart';
import 'package:green_puducherry/providers/bottom_nav_provider.dart';
import 'package:provider/provider.dart';

import '../../gallery/pages/all_plant_gallery.dart';

class AddPhotoMessage extends StatefulWidget {
  const AddPhotoMessage({super.key});

  @override
  State<AddPhotoMessage> createState() => _AddPhotoMessageState();
}

class _AddPhotoMessageState extends State<AddPhotoMessage> {
  final ConfettiController _controllerCenterRight =
      ConfettiController(duration: const Duration(milliseconds: 100));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerCenterRight.play();
  }

  @override
  Widget build(BuildContext context) {
    final bnp = Provider.of<BottomNavProvider>(context);

    return BackgroundScaffold(
      body: WillPopScope(
        onWillPop: () async => await willPopBack(context),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    GreenImages.kTrees,
                    width: 0.8.sw,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    // "Congratulations on your tree planting efforts! Your actions are helping create a greener and healthier world for future generations. We appreciate your dedication to nature and your valuable contribution to a more sustainable future. Keep up the fantastic work",
                    "Congratulations on your tree planting efforts! Your next opportunity to upload a photo for the plant will be available on after 3 months",
                    style: TextStyle(
                        fontSize: 17.sp, color: GreenColors.kMainColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  GreenButton(
                    text: "View Gallery",
                    onPressed: () {
                      bnp.setIndex(1);
                      MyNavigation.offAll(context, const AllPlantsGallery());
                      _controllerCenterRight.play();
                    },
                  ),
                ],
              ),
            ),
            Positioned(
                left: 0.5.sw,
                top: 0.0.sh,
                child: ConfettiWidget(
                  confettiController: _controllerCenterRight,
                  emissionFrequency: 0.4,
                  maxBlastForce: 35,
                  minBlastForce: 5,
                  numberOfParticles: 100,
                  gravity: 0.1,
                  blastDirectionality: BlastDirectionality.explosive,
                  colors: const [
                    Color(0xff3acb46),
                    Color(0xffef1ea2),
                    Color(0xfff32a2a),
                    Color(0xff10f1de),
                    Color(0xff0b5dfd),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
