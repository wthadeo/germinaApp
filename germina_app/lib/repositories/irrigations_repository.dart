import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/hour.dart';
import 'package:germina_app/models/irrigation.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/sensors/soil_sensor.dart';
import 'package:germina_app/models/sensors/temp_sensor.dart';

class IrrigationsRepository extends ChangeNotifier {
  static List<Irrigation> listOfIrrigations = [
    Irrigation(
        'Irrigation X',
        Hour(0, 0),
        30,
        12,
        40.55,
        Crop('Cultivo X', '05-10-2021', 2, true, []),
        [
          SoilSensor(20,
              name: 'sensor_soil2',
              protocol: 'unknown protocol',
              uri: 'unknown uri',
              category: 'soilSensor'),
          TempSensor(
            36,
            38,
            name: 'sensor_temperature1',
            protocol: 'unknown protocol',
            uri: 'unknown uri',
          )
        ],
        [
          Nutrient('Nutriente X', 250, 0.85),
          Nutrient('Nutriente Y', 120, 0.70)
        ],
        true,
        []),
  ];

  UnmodifiableListView<Irrigation> get lista =>
      UnmodifiableListView(listOfIrrigations);

  saveAll(List<Irrigation> irrigations) {
    irrigations.forEach((irrigation) {
      if (!listOfIrrigations.contains(irrigation)) {
        listOfIrrigations.add(irrigation);
      }
    });
    notifyListeners();
  }

  remove(Irrigation irrigation) {
    listOfIrrigations.remove(irrigation);
    notifyListeners();
  }
}
