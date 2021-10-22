import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/hour.dart';
import 'package:germina_app/models/notification.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/sensors/sensor.dart';

class Irrigation {
  String name;
  Hour startHour;
  int timeToUse;
  int flowRate;
  double energy;
  Crop crop;
  List<Sensor> sensor;
  List<Nutrient> nutrient;
  bool state;
  List<Notification> listOfNotifications;

  Irrigation(
      {required this.name,
      required this.startHour,
      required this.timeToUse,
      required this.flowRate,
      required this.energy,
      required this.crop,
      required this.sensor,
      required this.nutrient,
      required this.state,
      required this.listOfNotifications});

  factory Irrigation.fromJson(dynamic json) {
    if (json['listOfNotifications'] != null) {
      var noteObjsJson = json['listOfNotifications'] as List;
      var sensorObjsJson = json['sensor'] as List;
      var nutrientObjsJson = json['nutrient'] as List;

      List<Notification> _notifications = noteObjsJson
          .map((noteJson) => Notification.fromJson(noteJson))
          .toList();

      List<Sensor> _sensors = sensorObjsJson
          .map((sensorJson) => Sensor.fromJson(sensorJson))
          .toList();
      List<Nutrient> _nutrients = nutrientObjsJson
          .map((nutrientJson) => Nutrient.fromJson(nutrientJson))
          .toList();

      return Irrigation(
          name: json['name'] as String,
          startHour: json['hour'] as Hour,
          timeToUse: json['timeToUse'] as int,
          flowRate: json['flowRate'] as int,
          energy: json['timeToUse'].toDouble(),
          crop: json['timeToUse'] as Crop,
          sensor: _sensors,
          nutrient: _nutrients,
          state: json['state'] as bool,
          listOfNotifications: _notifications);
    } else {
      var sensorObjsJson = json['sensor'] as List;
      var nutrientObjsJson = json['nutrient'] as List;

      List<Sensor> _sensors = sensorObjsJson
          .map((sensorJson) => Sensor.fromJson(sensorJson))
          .toList();
      List<Nutrient> _nutrients = nutrientObjsJson
          .map((nutrientJson) => Nutrient.fromJson(nutrientJson))
          .toList();

      return Irrigation(
          name: json['name'] as String,
          startHour: json['hour'] as Hour,
          timeToUse: json['timeToUse'] as int,
          flowRate: json['flowRate'] as int,
          energy: json['timeToUse'].toDouble(),
          crop: json['timeToUse'] as Crop,
          sensor: _sensors,
          nutrient: _nutrients,
          state: json['state'] as bool,
          listOfNotifications: []);
    }
  }
}
