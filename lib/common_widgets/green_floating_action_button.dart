import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:green_puducherry/models/plant_model.dart';
import 'package:green_puducherry/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../constant/green_colors.dart';
import '../helpers/my_navigation.dart';
import '../providers/plant_provider.dart';
import '../screens/add_photo/pages/all_plant_list.dart';
import '../screens/add_photo/pages/select_plant.dart';

class GreenFloatingActionButton extends StatefulWidget {
  const GreenFloatingActionButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  State<GreenFloatingActionButton> createState() =>
      _GreenFloatingActionButtonState();
}

class _GreenFloatingActionButtonState extends State<GreenFloatingActionButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        MyNavigation.to(context, AllPlantList());
      },
      backgroundColor: Colors.white,
      child: loading
          ? CircularProgressIndicator(
              color: GreenColors.kMainColor,
            )
          : const Icon(
              FeatherIcons.plus,
              color: GreenColors.kMainColor,
            ),
    );
  }
}
