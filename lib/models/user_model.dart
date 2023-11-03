import 'package:green_puducherry/models/plant_model.dart';

import 'commune_model.dart';
import 'region_model.dart';

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String mobileNumber;
  final String regionId;
  final String communeId;
  final String address;
  final String pincode;
  final String date;
  final RegionModel region;
  final CommuneModel commune;
  PlantModel? plantModel;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.mobileNumber,
    required this.regionId,
    required this.communeId,
    required this.address,
    required this.pincode,
    required this.date,
    required this.region,
    required this.commune,
    this.plantModel,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      regionId: json['regionId'],
      communeId: json['communeId'],
      address: json['address'],
      pincode: json['pincode'],
      date: json['date'],
      region: RegionModel.fromJson(json['region']),
      commune: CommuneModel.fromJson(json['commune']),
      plantModel: json["plantDetailsData"] != null
          ? PlantModel.fromJson(json["plantDetailsData"])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapData = {};
    mapData['_id'] = id;
    mapData['userName'] = userName;
    mapData['email'] = email;
    mapData['mobileNumber'] = mobileNumber;
    mapData['regionId'] = regionId;
    mapData['communeId'] = communeId;
    mapData['address'] = address;
    mapData['pincode'] = pincode;
    mapData['date'] = date;
    mapData['region'] = region.convertIntoMap();
    mapData['commune'] = commune.convertIntoMap();

    return mapData;
  }
}
