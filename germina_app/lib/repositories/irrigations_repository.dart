import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/hour.dart';
import 'package:germina_app/models/irrigation.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/sensors/soil_sensor.dart';

class IrrigationsRepository extends ChangeNotifier {
  static List<Irrigation> listOfIrrigations = [
    Irrigation('Irrigation X', Hour(0,0), 0, 0, '', Crop('', '', 0, false, []), SoilSensor(0,name: '', protocol: '', uri: '', category: ''), Nutrient('', '', 0, 0), true),
    Irrigation('Irrigation Y', Hour(0,0), 0, 0, '', Crop('', '', 0, false, []), SoilSensor(0,name: '', protocol: '', uri: '', category: ''), Nutrient('', '', 0, 0), false),
  ];

  UnmodifiableListView<Irrigation> get lista =>
      UnmodifiableListView(listOfIrrigations);

  saveAll(List<Irrigation> irrigations) {
    irrigations.forEach((irrigation) {
      if (!listOfIrrigations.contains(irrigation)){
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
