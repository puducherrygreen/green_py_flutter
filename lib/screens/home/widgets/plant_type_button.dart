import 'package:flutter/material.dart';
import 'package:green_puducherry/helpers/my_navigation.dart';
import 'package:green_puducherry/models/plant_land_model.dart';
import 'package:provider/provider.dart';

import '../../../providers/plant_provider.dart';
import '../../add_photo/pages/select_plant.dart';

class PlantTypeButton extends StatelessWidget {
  const PlantTypeButton(
      {super.key, required this.plantLandModel, this.onPressed});
  final PlantLandModel plantLandModel;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<PlantProvider>(context);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onPressed ??
            () {
              plantProvider.setPlantType(plantLandModel);
              print(plantLandModel.landName);
              print(plantLandModel.id);
              MyNavigation.replace(context, SelectPlant());
            },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            plantLandModel.landName,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
