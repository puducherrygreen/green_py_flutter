class PlantLandModel {
  final String id;
  final String landName;

  PlantLandModel({required this.id, required this.landName});

  factory PlantLandModel.fromJson(Map<String, dynamic> json) {
    print('plant-land-json --------- $json');
    return PlantLandModel(id: json['_id'], landName: json['landName']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapData = {};
    mapData['_id'] = id;
    mapData['landName'] = landName;
    return mapData;
  }
}
