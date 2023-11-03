class RegionModel {
  final String id;
  final String regionName;

  RegionModel({required this.id, required this.regionName});

  factory RegionModel.fromJson(json) {
    return RegionModel(id: json['_id'], regionName: json['regionName']);
  }
  convertIntoMap() {
    Map<String, dynamic> mapData = {};
    mapData['_id'] = id;
    mapData['regionName'] = regionName;
  }
}
