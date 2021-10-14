import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/models/sensors/soil_sensor.dart';
import 'package:germina_app/models/sensors/temp_sensor.dart';

class SensorsRepository extends ChangeNotifier{

  static List<Sensor> listOfSensors = [
    SoilSensor(25,
        name: 'sensor_soil1',
        protocol: 'unknown protocol',
        uri: 'unknown uri',
        category: 'soilSensor'),
    TempSensor(
      40,
      42,
      name: 'sensor_temperature2',
      protocol: 'unknown protocol',
      uri: 'unknown uri',
    ),
    SoilSensor(
      20,
      name: 'sensor_soil2',
      protocol: 'unknown protocol',
      uri: 'unknown uri',
    ),
    SoilSensor(
      40,
      name: 'sensor_soil3',
      protocol: 'unknown protocol',
      uri: 'unknown uri',
    ),
    TempSensor(
      36,
      38,
      name: 'sensor_temperature1',
      protocol: 'unknown protocol',
      uri: 'unknown uri',
    ),
  ];

  UnmodifiableListView<Sensor> get lista => UnmodifiableListView(listOfSensors);

  saveAll(List<Sensor> sensors){
    sensors.forEach((sensor) {
      if(!listOfSensors.contains(sensor)) listOfSensors.add(sensor);
     });
    notifyListeners();
  }

  remove(Sensor sensor){
    listOfSensors.remove(sensor);
    notifyListeners();
  }


}