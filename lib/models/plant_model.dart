import 'package:green_puducherry/models/plant_image_model.dart';
import 'package:green_puducherry/models/plant_land_model.dart';

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
  final String? updateDateNextPhoto;
  final bool nextPhotoEnabled;
  final List<PlantImageModel> plantImages;
  final String availablePlantId;
  final PlantLandModel? plantLand;

  PlantModel({
    required this.id,
    required this.plantName,
    required this.userId,
    required this.communeId,
    required this.regionId,
    required this.longitude,
    required this.latitude,
    required this.status,
    this.plantLand,
    required this.date,
    required this.nextPhotoEnabled,
    this.updateDateNextPhoto,
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
    print('plant-land---------------------------------------');
    print(json['plantLand']);
    print(json);
    print('plant-land---------------------------------------');

    return PlantModel(
      id: json['_id'],
      plantName: json['plantName'] ?? "Testing Plant Name",
      userId: json['userId'],
      communeId: json['communeId'],
      regionId: json['regionId'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      status: json['status'],
      plantLand: PlantLandModel.fromJson(json['plantLand']),
      date: json['date'],
      updateDateNextPhoto: json['updateDateNextPhoto'],
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
    mapData['plantLand'] = plantLand?.toMap();
    mapData['date'] = date;
    mapData['updateDateNextPhoto'] = updateDateNextPhoto;
    mapData['nextPhotoEnabled'] = nextPhotoEnabled;
    mapData['availablePlantId'] = availablePlantId;
    mapData['plantImagesData'] =
        plantImages.map((e) => e.convertIntoMap()).toList();
    return mapData;
  }
}
