import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView({
    super.key,
    required this.globalKey,
    required this.title,
    required this.description,
    required this.child,
    this.showDone = false,
    this.shapeBorder = const CircleBorder(),
  });

  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;
  final showDone;

  @override
  Widget build(BuildContext context) {
    return showDone
        ? child
        : Showcase(
            key: globalKey,
            description: description,
            targetShapeBorder: shapeBorder,
            child: child);
  }
}
