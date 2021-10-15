import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:germina_app/models/nutrient.dart';

class NutrientsRepository extends ChangeNotifier {
  static List<Nutrient> listOfNutrients = [
    Nutrient('Nutriente X', '20-40', 250, 25.50),
    Nutrient('Nutriente Y', '60-100', 120, 85.00),
  ];

  UnmodifiableListView<Nutrient> get lista =>
      UnmodifiableListView(listOfNutrients);

  saveAll(List<Nutrient> nutrients) {
    nutrients.forEach((nutrient) {
      if (!listOfNutrients.contains(nutrient)) {
        listOfNutrients.add(nutrient);
      }
    });
    notifyListeners();
  }

  remove(Nutrient nutrient) {
    listOfNutrients.remove(nutrient);
    notifyListeners();
  }
}
