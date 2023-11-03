import 'package:flutter/material.dart';
import 'package:green_puducherry/common_widgets/background_scaffold.dart';
import 'package:green_puducherry/common_widgets/common_widgets.dart';
import 'package:green_puducherry/common_widgets/green_appbar.dart';
import 'package:green_puducherry/common_widgets/green_buttons.dart';
import 'package:green_puducherry/common_widgets/image_for_profile.dart';
import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/models/plant_image_model.dart';
import 'package:green_puducherry/providers/plant_provider.dart';
import 'package:provider/provider.dart';

class SelectedImageGallery extends StatelessWidget {
  SelectedImageGallery({super.key});
  final List<PlantImageModel> allImages = [
    PlantImageModel(
        id: "d",
        date: DateTime(1998, 02, 28).toString(),
        plantImage:
            "https://firebasestorage.googleapis.com/v0/b/green-puducherry.appspot.com/o/Plant_Images%2FCAP2262916880313503765.jpg?alt=media&token=86a5c1b4-1fa2-4385-b1b3-f3bd0ac1adab"),
    PlantImageModel(
        id: "d",
        date: DateTime(1998, 02, 28).toString(),
        plantImage:
            "https://firebasestorage.googleapis.com/v0/b/green-puducherry.appspot.com/o/Plant_Images%2FCAP2262916880313503765.jpg?alt=media&token=86a5c1b4-1fa2-4385-b1b3-f3bd0ac1adab"),
    PlantImageModel(
        id: "d",
        date: DateTime(1998, 02, 28).toString(),
        plantImage:
            "https://firebasestorage.googleapis.com/v0/b/green-puducherry.appspot.com/o/Plant_Images%2FCAP2262916880313503765.jpg?alt=media&token=86a5c1b4-1fa2-4385-b1b3-f3bd0ac1adab"),
    PlantImageModel(
        id: "d",
        date: DateTime(1998, 02, 28).toString(),
        plantImage:
            "https://firebasestorage.googleapis.com/v0/b/green-puducherry.appspot.com/o/Plant_Images%2FCAP2262916880313503765.jpg?alt=media&token=86a5c1b4-1fa2-4385-b1b3-f3bd0ac1adab"),
  ];

  // ImageForView(imageModel: e)
  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<PlantProvider>(context);
    return BackgroundScaffold(
        appBar: greenAppBar(title: "Image Gallery", leading: GreenBackButton()),
        body: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: plantProvider.allSelectedPlant
              .map((e) => buildImageContainer(context, plantImageModel: e))
              .toList(),
        ));
  }

  Widget buildImageContainer(BuildContext context,
          {required PlantImageModel plantImageModel}) =>
      GestureDetector(
        onTap: () async {
          showDialog(
              context: context,
              builder: (value) {
                return AlertDialog(
                    content: Image.network(plantImageModel.plantImage));
              });
        },
        child: Container(
          decoration: BoxDecoration(
            color: GreenColors.kMainColor50,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(plantImageModel.plantImage),
                fit: BoxFit.cover),
          ),
        ),
      );
}
