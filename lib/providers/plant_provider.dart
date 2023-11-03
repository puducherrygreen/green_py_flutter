import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_puducherry/constant/green_text.dart';
import 'package:green_puducherry/helpers/local_storage.dart';
import 'package:green_puducherry/models/plant_image_model.dart';
import 'package:green_puducherry/models/plant_model.dart';
import 'package:green_puducherry/services/plant_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constant/green_colors.dart';
import '../helpers/my_navigation.dart';
import '../models/available_plant_model.dart';
import '../screens/add_photo/pages/camera_page.dart';
import '../screens/add_photo/pages/photo_info_page.dart';
import 'auth_provider.dart';

class PlantProvider extends ChangeNotifier {
  final AuthProvider _authProvider = AuthProvider();
  PlantProvider() {
    loadLocalPlant();
    getAllSelectedPlant();
    getCurrentLocation();
  }

  final PlantService _plantService = PlantService();

  List<AvailablePlantModel> availablePlants = [];
  AvailablePlantModel? selectedPlantModel;
  PlantModel? plantModel;
  bool isAlive = true;
  Position? location;
  List<PlantImageModel> allSelectedPlant = [];

  String getCurrentTime() {
    DateTime ct = DateTime.now();
    return "${ct.day}-${ct.month}-${ct.year}";
  }

  setPlantStatus(bool status) {
    isAlive = status;
    notifyListeners();
  }

  getAvailablePlants() async {
    List<dynamic> listOfPlants = await _plantService.getAvailablePlants();
    availablePlants =
        listOfPlants.map((e) => AvailablePlantModel.fromJson(e)).toList();
    print(availablePlants);
    notifyListeners();
  }

  Future<PlantModel?> getUserPlants({required String userId}) async {
    PlantModel? resPlant = await _plantService.getUserPlants(userId: userId);
    plantModel = resPlant;
    print('model trest -----------');
    print('userId-- : $userId');
    print(resPlant?.convertIntoMap());
    print(plantModel);
    print('model trest -----------');
    if (plantModel != null) {
      LocalStorage.setMap(GreenText.kPlantInfo, plantModel?.convertIntoMap());
    }

    notifyListeners();
    return resPlant;
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
    List<PlantImageModel>? p_image = await _plantService.getSelectedPlant();
    allSelectedPlant = p_image ?? [];
    notifyListeners();
  }

  loadLocalPlant() async {
    Map? plantInfo = await LocalStorage.getMap(GreenText.kPlantInfo);
    print("plant Info -----------------");
    print(plantInfo);
    if (plantInfo != null) {
      plantModel = PlantModel.fromJson(plantInfo);
      notifyListeners();
    } else {
      String? userId = await LocalStorage.getString(GreenText.kUserId);
      print("plant Info  with userId--- $userId--------------");

      if (userId != null) {
        await getUserPlants(userId: userId);
      }
    }
  }

  //////
  myDialogShowStatusDialog(BuildContext context,
      {required PlantProvider plantProvider}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("We need to Know Your Plant Status"),
            titleTextStyle: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  color: GreenColors.kMainColor,
                  onPressed: () {
                    plantProvider.setPlantStatus(true);
                    MyNavigation.to(context, CameraPage());
                  },
                  child: const Text(
                    "Alive",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MaterialButton(
                  color: Colors.red[600],
                  onPressed: () {
                    plantProvider.setPlantStatus(false);
                    MyNavigation.to(context, CameraPage());
                  },
                  child: const Text(
                    "Dead",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        });
  }

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

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, you can now use the location.
    } else {
      // Permission denied.
    }
  }
}
