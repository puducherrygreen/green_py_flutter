import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import '../helpers/green_drawer_key.dart';
import '../helpers/my_navigation.dart';

class GreenMenuButton extends StatelessWidget {
  const GreenMenuButton({
    Key? key,
    this.color,
    this.onPressed,
    this.scaffoldKey,
  }) : super(key: key);

  final Color? color;
  final VoidCallback? onPressed;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: IconButton(
        icon: const Icon(FeatherIcons.menu),
        color: color ?? Colors.black38,
        iconSize: 25,
        splashRadius: 25,
        onPressed: onPressed ??
            () {
              scaffoldKey?.currentState?.openDrawer();
              // MyNavigation.back(context);
            },
      ),
    );
  }
}

class GreenBackButton extends StatelessWidget {
  const GreenBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        MyNavigation.back(context);
      },
      icon: const Icon(
        FeatherIcons.arrowLeft,
        color: Colors.black45,
      ),
    );
  }
}
