class CommuneModel {
  final String id;
  final String regionId;
  final String communeName;

  CommuneModel(
      {required this.id, required this.communeName, required this.regionId});

  factory CommuneModel.fromJson(json) {
    return CommuneModel(
        id: json['_id'],
        communeName: json['communeName'],
        regionId: json['regionId']);
  }

  convertIntoMap() {
    Map<String, dynamic> mapData = {};
    mapData['_id'] = id;
    mapData['communeName'] = communeName;
  }
}
