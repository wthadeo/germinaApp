import 'package:germina_app/models/sensors/sensor.dart';

class Device {
  String name;
  String uri;
  String protocol;
  List<Sensor> sensors;
  String longitude;
  String latitude;

  Device(
      {required this.name,
      required this.uri,
      required this.protocol,
      required this.sensors,
      required this.longitude,
      required this.latitude});

  factory Device.fromJson(Map<String, dynamic> json) {
    var listSensors = json['sensors'] as List;

    List<Sensor> _sensors = listSensors.map((v) => Sensor.fromJson(v)).toList();

    return Device(
      name: json['name'],
      uri: json['uri'],
      protocol: json['protocol'],
      sensors: _sensors,
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['uri'] = uri;
    data['protocol'] = protocol;
    data['sensors'] = sensors.map((v) => v.toJson()).toList();
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
