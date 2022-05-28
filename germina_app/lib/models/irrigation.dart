import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/notification.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/sensors/sensor.dart';

class Irrigation {
  String name;
  int startHour;
  int startMinutes;
  int timeToUse;
  int flowRate;
  double energy;
  List<Crop> crop;
  List<Sensor> sensor;
  List<Nutrient> nutrient;
  bool state;
  List<Notification> listOfNotifications;

  Irrigation(
      {required this.name,
      required this.startHour,
      required this.startMinutes,
      required this.timeToUse,
      required this.flowRate,
      required this.energy,
      required this.crop,
      required this.sensor,
      required this.nutrient,
      required this.state,
      required this.listOfNotifications});

  factory Irrigation.fromJson(Map<String, dynamic> json) {
    var listCrops = json['crop'] as List;
    var listSensors = json['sensor'] as List;
    var listNutrients = json['nutrient'] as List;

    List<Crop> _crops = listCrops.map((v) => Crop.fromJson(v)).toList();
    List<Sensor> _sensors = listSensors.map((v) => Sensor.fromJson(v)).toList();
    List<Nutrient> _nutrients =
        listNutrients.map((v) => Nutrient.fromJson(v)).toList();
    List<Notification> _notifications = [];

    return Irrigation(
        name: json['name'],
        startHour: json['startHour'],
        startMinutes: json['startMinutes'],
        timeToUse: json['timeToUse'],
        flowRate: json['flowRate'],
        energy: json['energy'].toDouble(),
        crop: _crops,
        sensor: _sensors,
        nutrient: _nutrients,
        state: json['state'],
        listOfNotifications: _notifications);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['startHour'] = startHour;
    data['startMinutes'] = startMinutes;
    data['timeToUse'] = timeToUse;
    data['flowRate'] = flowRate;
    data['energy'] = energy;
    data['crop'] = crop.map((v) => v.toJson()).toList();
    data['sensor'] = sensor.map((v) => v.toJson()).toList();
    data['nutrient'] = nutrient.map((v) => v.toJson()).toList();
    data['state'] = state;
    data['listOfNotifications'] = [];
    return data;
  }

  /*
  factory Irrigation.fromJson(dynamic json) {
    if (json['listOfNotifications'] != null) {
      var noteObjsJson = json['listOfNotifications'] as List;
      var sensorObjsJson = json['sensor'] as List;
      var nutrientObjsJson = json['nutrient'] as List;
      var cropObjsJson = json['crop'] as List;

      List<Notification> _notifications = noteObjsJson
          .map((noteJson) => Notification.fromJson(noteJson))
          .toList();

      List<Sensor> _sensors = sensorObjsJson
          .map((sensorJson) => Sensor.fromJson(sensorJson))
          .toList();
      List<Nutrient> _nutrients = nutrientObjsJson
          .map((nutrientJson) => Nutrient.fromJson(nutrientJson))
          .toList();

      List<Crop> _crops = cropObjsJson.map((cropJson) => Crop.fromJson(cropJson)).toList();

      return Irrigation(
          name: json['name'] as String,
          startHour: json['startHour'] as int,
          startMinutes: json['startMinutes'] as int,
          timeToUse: json['timeToUse'] as int,
          flowRate: json['flowRate'] as int,
          energy: json['timeToUse'].toDouble(),
          crop: _crops,
          sensor: _sensors,
          nutrient: _nutrients,
          state: json['state'] as bool,
          listOfNotifications: _notifications);
    } else {
      var sensorObjsJson = json['sensor'] as List;
      var nutrientObjsJson = json['nutrient'] as List;
      var cropObjsJson = json['crop'] as List;

      List<Sensor> _sensors = sensorObjsJson
          .map((sensorJson) => Sensor.fromJson(sensorJson))
          .toList();
      List<Nutrient> _nutrients = nutrientObjsJson
          .map((nutrientJson) => Nutrient.fromJson(nutrientJson))
          .toList();

      List<Crop> _crops = cropObjsJson.map((cropJson) => Crop.fromJson(cropJson)).toList();

      return Irrigation(
          name: json['name'] as String,
          startHour: json['startHour'] as int,
          startMinutes: json['startMinutes'] as int,
          timeToUse: json['timeToUse'] as int,
          flowRate: json['flowRate'] as int,
          energy: json['timeToUse'].toDouble(),
          crop: _crops,
          sensor: _sensors,
          nutrient: _nutrients,
          state: json['state'] as bool,
          listOfNotifications: []);
    }
  }

  */

}
