import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/models/sensors/soil_sensor.dart';
import 'package:germina_app/models/sensors/temp_sensor.dart';

class SensorsRepository extends ChangeNotifier {
  static List<Sensor> listOfSensors = [
    SoilSensor(0,
        name: 'sensor_soil',
        protocol: 'mqtt',
        uri: 'unknown uri',
        category: 'soilSensor'),
    TempSensor(
      0,
      0,
      name: 'sensor_temperature',
      protocol: 'mqtt',
      uri: 'unknown uri',
    )
  ];

  UnmodifiableListView<Sensor> get lista => UnmodifiableListView(listOfSensors);

  saveAll(List<Sensor> sensors) {
    // ignore: avoid_function_literals_in_foreach_calls
    sensors.forEach((sensor) {
      if (!listOfSensors.contains(sensor)) listOfSensors.add(sensor);
    });
    notifyListeners();
  }

  refreshAll() {
    notifyListeners();
  }

  remove(Sensor sensor) {
    listOfSensors.remove(sensor);
    notifyListeners();
  }
}
