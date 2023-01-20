class StationModel {
  String stationName;
  List<String> stationLines;
  List<String> layout;
  List<String> platforms;
  int disablityAccess;
  int elevators;
  int parking;
  double latitude;
  double longitude;

  StationModel({
    required this.stationName,
    required this.stationLines,
    required this.disablityAccess,
    required this.elevators,
    required this.parking,
    required this.layout,
    required this.platforms,
    required this.latitude,
    required this.longitude,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      stationName: json['name'],
      disablityAccess: json['details']['disabled friendly'],
      elevators: json['details']['elevator available'],
      parking: json['details']['parking available'],
      stationLines: List<String>.from(json['details']['line']),
      layout: List<String>.from(json['details']['layout']),
      latitude: json['details']['latitude'],
      platforms: List<String>.from(json['details']['platform']),
      longitude: json['details']['longitude'],
    );
  }
}
