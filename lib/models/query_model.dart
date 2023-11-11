class QueryModel {
  final String id;
  final String query;
  final String? response;
  final String date;
  final String? responseDate;

  QueryModel({
    required this.id,
    this.response,
    required this.query,
    required this.date,
    this.responseDate,
  });

  factory QueryModel.fromJson(json) {
    return QueryModel(
        id: json['_id'],
        response: json['response'],
        query: json['query'],
        date: json['date'],
        responseDate: json['responseDate']);
  }

  convertIntoMap() {
    Map<String, dynamic> mapData = {};
    mapData['_id'] = id;
    mapData['query'] = query;
    mapData['date'] = date;
    mapData['response'] = response;
    mapData['responseDate'] = responseDate;
  }
}
