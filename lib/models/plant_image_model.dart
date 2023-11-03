class PlantImageModel {
  final String id;
  final String plantImage;
  final String date;
  final String? longitude;
  final String? latitude;
  final String? status;

  PlantImageModel(
      {required this.id,
      required this.plantImage,
      required this.date,
      this.latitude,
      this.longitude,
      this.status});

  factory PlantImageModel.fromJson(json) {
    return PlantImageModel(
        id: json['_id'],
        plantImage: json['imageUrl'],
        date: json['date'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        status: json['status']);
  }
  formattedDate() {
    DateTime id = DateTime.parse(date);
    return "${id.day}-${id.month}-${id.year}";
  }

  convertIntoMap() {
    Map<String, dynamic> mapData = {};
    mapData['_id'] = id;
    mapData['imageUrl'] = plantImage;
    mapData['date'] = date;
    mapData['longitude'] = longitude;
    mapData['latitude'] = latitude;
    mapData['status'] = status;
    return mapData;
  }
}
