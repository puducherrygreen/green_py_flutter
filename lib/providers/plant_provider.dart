import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_puducherry/constant/green_text.dart';
import 'package:green_puducherry/helpers/local_storage.dart';
import 'package:green_puducherry/models/plant_image_model.dart';
import 'package:green_puducherry/models/plant_land_model.dart';
import 'package:green_puducherry/models/plant_model.dart';
import 'package:green_puducherry/services/plant_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constant/green_colors.dart';
import '../helpers/my_navigation.dart';
import '../models/available_plant_model.dart';
import '../screens/add_photo/pages/camera_page.dart';

class PlantProvider extends ChangeNotifier {
  PlantProvider() {
    loadLocalPlant();
    loadPlants();
    getAllSelectedPlant();
    // getCurrentLocation();
    // getAllPermissionRequest();
  }

  final PlantService _plantService = PlantService();

  List<AvailablePlantModel> availablePlants = [];
  AvailablePlantModel? selectedPlantModel;
  List<PlantModel> plantModels = [];
  List<PlantLandModel> allPlantLands = [];
  PlantModel? currentPlantModel;
  bool? isAlive;
  Position? location;
  List<PlantImageModel> allSelectedPlant = [];
  PlantLandModel? plantLand;

  String getCurrentTime() {
    DateTime ct = DateTime.now();
    return "${ct.day}-${ct.month}-${ct.year}";
  }

  setPlantType(PlantLandModel plantTypeValue) async {
    plantLand = plantTypeValue;
    await getAvailablePlants(landId: plantTypeValue.id);
    notifyListeners();
  }

  getPlantLands() async {
    allPlantLands.clear();
    List? data = await _plantService.getPlantLands();
    for (Map<String, dynamic> land in data ?? []) {
      allPlantLands.add(PlantLandModel.fromJson(land));
    }
    notifyListeners();
  }

  removePlantType() {
    plantLand = null;
  }

  bool setPlantStatus(bool status) {
    isAlive = status;
    notifyListeners();
    return status;
  }

  setCurrentPlant(PlantModel plantModel) async {
    String? userId = await LocalStorage.getString(GreenText.kUserId);
    if (userId != null) {
      PlantModel? newPlantModel =
          await _plantService.getPlantByPlantIs(plantId: plantModel.id);
      if (newPlantModel != null) {
        currentPlantModel = newPlantModel;
      } else {
        currentPlantModel = plantModel;
      }
      notifyListeners();
    }
  }

  removeCurrentPlant() {
    currentPlantModel = null;
  }

  getAvailablePlants({required String landId}) async {
    List<dynamic> listOfPlants =
        await _plantService.getAvailablePlants(landId: landId);
    availablePlants =
        listOfPlants.map((e) => AvailablePlantModel.fromJson(e)).toList();
    print(availablePlants);
    notifyListeners();
  }

  Future<List<PlantModel>?> getUserPlants({required String userId}) async {
    List<PlantModel>? resPlant =
        await _plantService.getUserPlants(userId: userId);
    plantModels = resPlant ?? [];
    print('model trest -----------');
    print('userId-- : $userId');
    print(plantModels);
    print('model trest -----------');
    if (plantModels.isNotEmpty) {
      // LocalStorage.setMap(GreenText.kPlantInfo, plantModel?.convertIntoMap());
      LocalStorage.setList(GreenText.kPlantInfo, convertAllPlantToMap());
    }
    // loadLocalPlant();

    notifyListeners();
    return resPlant;
  }

  loadPlants() async {
    String? userId = await LocalStorage.getString(GreenText.kUserId);
    if (userId != null) {
      getUserPlants(userId: userId);
    }
  }

  List<Map<String, dynamic>> convertAllPlantToMap() {
    List<Map<String, dynamic>> mapList = [];
    for (PlantModel i in plantModels) {
      mapList.add(i.convertIntoMap());
    }
    return mapList;
  }

  getSelectedPlantWithId({required String plantName}) {
    for (AvailablePlantModel i in availablePlants) {
      if (plantName == i.plantName) {
        selectedPlantModel = i;
        notifyListeners();
        return;
      }
    }
  }

  addPlantPhoto({required Map<String, dynamic> plantData}) async {
    final data = await _plantService.addPlant(plantData: plantData);
    print('add-plant data res -------------------');
    print(data);
    String? userId = await LocalStorage.getString(GreenText.kUserId);
    if (userId != null) {
      getUserPlants(userId: userId);
    }

    await loadLocalPlant();
    print('add-plant data res -------------------');
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position localPos = await Geolocator.getCurrentPosition();
    location = localPos;
    notifyListeners();
    return localPos;
  }

  getAllSelectedPlant() async {
    List<PlantImageModel>? pImage = await _plantService.getSelectedPlant();
    allSelectedPlant = pImage ?? [];
    notifyListeners();
  }

  loadLocalPlant() async {
    List? plantInfo = await LocalStorage.getList(GreenText.kPlantInfo);
    print("plant Info -----------------");
    print(plantInfo);
    if (plantInfo != null) {
      List<PlantModel> allPlantModel = [];
      for (Map i in plantInfo) {
        allPlantModel.add(PlantModel.fromJson(i));
      }
      plantModels = allPlantModel;
      notifyListeners();
    } else {
      String? userId = await LocalStorage.getString(GreenText.kUserId);
      print("plant Info  with userId--- $userId--------------");
      return;
    }
  }

  // myDialogShowStatusDialog(BuildContext context,
  //     {required PlantProvider plantProvider}) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text("We need to Know Your Plant Status"),
  //           titleTextStyle: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
  //           content: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               MaterialButton(
  //                 color: isAlive != null
  //                     ? isAlive ?? true
  //                         ? GreenColors.kMainColor
  //                         : GreenColors.kSecondColor
  //                     : GreenColors.kSecondColor,
  //                 onPressed: () {
  //                   plantProvider.setPlantStatus(true);
  //                   // MyNavigation.to(context, const CameraPage());
  //                 },
  //                 child: const Text(
  //                   "Alive",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //               MaterialButton(
  //                 color: isAlive != null
  //                     ? isAlive ?? true
  //                         ? GreenColors.kSecondColor
  //                         : Colors.red[600]
  //                     : GreenColors.kSecondColor,
  //                 onPressed: () {
  //                   plantProvider.setPlantStatus(false);
  //                   // MyNavigation.to(context, const CameraPage());
  //
  //                 },
  //                 child: const Text(
  //                   "Dead",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }

  Future<void> showPermissionRequestDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Permission Request'),
          content: const Text(
            "To enhance your experience in our app and help you track your plant's growth, we need access to your camera and location. The camera permission will allow you to capture and document your plant's progress by taking photos, while the location permission is crucial for accurately tracking the plant's geographic information. Would you please grant us permission to access your camera and location?",
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _requestCameraPermission();
                _requestLocationPermission();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Grant Permission'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      // Permission granted, you can now use the camera.
    } else {
      // Permission denied.
    }
  }

  Future<void> _requestAudioPermission() async {
    final status = await Permission.audio.request();
    if (status.isGranted) {
      // Permission granted, you can now use the camera.
    } else {
      // Permission denied.
    }
  }

  Future<void> _requestMicroPermission() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      // Permission granted, you can now use the camera.
    } else {
      // Permission denied.
    }
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, you can now use the location.
      location = await Geolocator.getCurrentPosition();
    } else {
      // Permission denied.
    }
  }

  Future<void> getAllPermissionRequest() async {
    await _requestLocationPermission();
    await _requestCameraPermission();
    await _requestAudioPermission();
    await _requestMicroPermission();
    await getCurrentLocation();
  }
}
