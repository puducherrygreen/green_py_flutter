import 'dart:convert';

import 'package:green_puducherry/constant/constant.dart';
import 'package:green_puducherry/constant/green_api.dart';
import 'package:green_puducherry/models/plant_image_model.dart';
import 'package:green_puducherry/models/plant_model.dart';
import 'package:http/http.dart' as http;

import '../helpers/local_storage.dart';

class PlantService {
  Future<List<dynamic>> getAvailablePlants() async {
    final client = http.Client();
    final res = await client.get(GreenApi.kGetAvailablePlant);
    final data = jsonDecode(res.body);
    print(data);
    return data;
  }

  Future<List<PlantModel>?> getUserPlants({required String userId}) async {
    final client = http.Client();
    final res = await client.get(Uri.https(
        GreenApi.kBaseUrl, "${GreenApi.kGetUserPlantByIdUrl}$userId"));
    final data = jsonDecode(res.body);
    print('-------------plant details data ------------');
    print(data);
    print('-------------plant details data ------------');
    if (data['plantDetailsData'] != null) {
      List listData = data['plantDetailsData'];
      List<PlantModel> allPlantModel = [];
      for (Map i in listData) {
        allPlantModel.add(PlantModel.fromJson(i));
      }

      return allPlantModel;
    }
    print('-------------plant details data end ------------');
    return null;
  }

  addPlant({required Map<String, dynamic> plantData}) async {
    final client = http.Client();
    final res = await client.post(GreenApi.kAddPlantImage, body: plantData);
    String? userid = await LocalStorage.getString(GreenText.kUserId);
    print(res.body);
    Map? plantInfo = jsonDecode(res.body);
    print("userid------------------$userid");
    if (plantInfo != null && userid != null) {
      getUserPlants(userId: userid);
    }
    return plantInfo;
  }

  Future<List<PlantImageModel>?> getSelectedPlant() async {
    try {
      final client = http.Client();
      final res = await client.get(GreenApi.kGetSelectedPlantUrl);

      List<dynamic> photoList = jsonDecode(res.body);
      List<PlantImageModel> allPlantsImage = [];
      for (Map i in photoList) {
        allPlantsImage.add(PlantImageModel.fromJson(i));
      }

      return allPlantsImage;
    } catch (e) {
      return null;
    }
  }
}
