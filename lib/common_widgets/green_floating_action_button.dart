import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:green_puducherry/models/plant_model.dart';
import 'package:green_puducherry/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../constant/green_colors.dart';
import '../helpers/my_navigation.dart';
import '../providers/plant_provider.dart';
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
    final plantProvider = Provider.of<PlantProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return FloatingActionButton(
      onPressed: () async {
        try {
          loading = true;
          setState(() {});
          authProvider.getLocalUser();
          if (authProvider.userModel != null) {
            PlantModel? plantModel = await plantProvider.getUserPlants(
                userId: authProvider.userModel!.id);
            print('plant-----model------- $plantModel');
            print(plantModel?.plantImages.length);
            if (plantModel == null) {
              plantProvider.getAvailablePlants();
            }

            if (context.mounted) {
              setState(() {
                loading = false;
              });
              MyNavigation.to(context, SelectPlant());
            }
          } else {
            print('userModel Null');
          }
        } catch (e) {
          loading = false;
          setState(() {});
        }
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
