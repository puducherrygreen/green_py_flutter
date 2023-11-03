import 'package:green_puducherry/models/available_plant_model.dart';
import 'package:green_puducherry/models/plant_image_model.dart';

class PlantModel {
  final String id;
  final String plantName;
  final String userId;
  final String communeId;
  final String regionId;
  final String longitude;
  final String latitude;
  final String status;
  final String date;
  final bool nextPhotoEnabled;
  final List<PlantImageModel> plantImages;
  final String availablePlantId;

  PlantModel({
    required this.id,
    required this.plantName,
    required this.userId,
    required this.communeId,
    required this.regionId,
    required this.longitude,
    required this.latitude,
    required this.status,
    required this.date,
    required this.nextPhotoEnabled,
    required this.plantImages,
    required this.availablePlantId,
  });

  factory PlantModel.fromJson(json) {
    List<PlantImageModel> plantImagesList = [];
    List<dynamic>? jsonPlantData = json['plantImagesData'];
    if (jsonPlantData != null) {
      if (jsonPlantData.isNotEmpty) {
        for (Map<String, dynamic> i in jsonPlantData) {
          plantImagesList.add(PlantImageModel.fromJson(i));
        }
      }
    }

    return PlantModel(
      id: json['_id'],
      plantName: json['plantName'] ?? "Testing Plant Name",
      userId: json['userId'],
      communeId: json['communeId'],
      regionId: json['regionId'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      status: json['status'],
      date: json['date'],
      nextPhotoEnabled: json['nextPhotoEnabled'],
      plantImages: plantImagesList,
      availablePlantId: json['availablePlantId'],
    );
  }
  convertIntoMap() {
    Map<String, dynamic> mapData = {};
    mapData['_id'] = id;
    mapData['plantName'] = plantName;
    mapData['userId'] = userId;
    mapData['communeId'] = communeId;
    mapData['regionId'] = regionId;
    mapData['longitude'] = longitude;
    mapData['latitude'] = latitude;
    mapData['status'] = status;
    mapData['date'] = date;
    mapData['nextPhotoEnabled'] = nextPhotoEnabled;
    mapData['availablePlantId'] = availablePlantId;
    mapData['plantImagesData'] =
        plantImages.map((e) => e.convertIntoMap()).toList();
    return mapData;
  }
}
