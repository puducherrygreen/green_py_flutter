class AvailablePlantModel {
  final String id;
  final String plantName;
  final bool active;

  AvailablePlantModel(
      {required this.id, required this.plantName, required this.active});

  factory AvailablePlantModel.fromJson(json) {
    return AvailablePlantModel(
        id: json['_id'], plantName: json['plantName'], active: json['active']);
  }

  convertIntoMap() {
    Map<String, dynamic> mapData = {};
    mapData['_id'] = id;
    mapData['plantName'] = plantName;
    mapData['active'] = active;
  }
}
