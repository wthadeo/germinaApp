import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:germina_app/models/nutrient.dart';

class NutrientsRepository extends ChangeNotifier {
  static List<Nutrient> listOfNutrients = [];

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
