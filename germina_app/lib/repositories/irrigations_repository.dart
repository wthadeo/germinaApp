import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:germina_app/models/irrigation.dart';

class IrrigationsRepository extends ChangeNotifier {
  static List<Irrigation> listOfIrrigations = [];

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
