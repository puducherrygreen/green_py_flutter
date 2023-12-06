import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/screens/contact/pages/contact.dart';
import 'package:green_puducherry/screens/home/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../providers/bottom_nav_provider.dart';
import 'gallery/pages/all_plant_gallery.dart';

class GreenBottomNav extends StatelessWidget {
  const GreenBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: GreenValues.kAppbarHeight,
      color: Colors.white.withOpacity(0.8),
      elevation: 0,
      child: Row(
        children: [
          BottomNavIcon(
            index: 0,
            iconData: FeatherIcons.home,
            screen: ShowCaseWidget(
              builder:
                  Builder(builder: (context) => Home(showcaseHidden: true)),
            ),
            label: "Home",
          ),
          const BottomNavIcon(
            index: 1,
            iconData: FeatherIcons.image,
            screen: AllPlantsGallery(),
            label: "Gallery",
          ),
          const BottomNavIcon(
            index: 2,
            iconData: FeatherIcons.mail,
            screen: Contact(),
            label: "Contact",
          ),
        ],
      ),
    );
  }
}

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    super.key,
    required this.index,
    required this.iconData,
    required this.screen,
    required this.label,
  });
  final int index;
  final IconData iconData;
  final Widget screen;
  final String label;
  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomNavProvider>(context);
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: () {
            bottomProvider.setIndex(index);
            MyNavigation.replace(context, screen);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 22.sp,
                color: bottomProvider.currentIndex == index
                    ? GreenColors.kMainColor
                    : Colors.grey,
              ),
              SizedBox(height: 5.h),
              Text(
                label,
                style: TextStyle(
                  color: bottomProvider.currentIndex == index
                      ? GreenColors.kMainColor
                      : Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
