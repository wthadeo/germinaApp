import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:http/http.dart' as http;

class NutrientsRepository extends ChangeNotifier {
  static List<Nutrient> listOfNutrients = [];

  UnmodifiableListView<Nutrient> get lista =>
      UnmodifiableListView(listOfNutrients);

  static Future<List<Nutrient>> getNutrientsFromApi(var url) async {
    http.Response res = await http.get((url));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Nutrient> nutrients = body
          .map(
            (dynamic item) => Nutrient.fromJson(item),
          )
          .toList();

      return nutrients;
    } else {
      throw "Unable to retrieve nutrients.";
    }
  }

  saveAll(List<Nutrient> nutrients) {
    // ignore: avoid_function_literals_in_foreach_calls
    nutrients.forEach((nutrient) {
      if (!listOfNutrients.contains(nutrient)) {
        listOfNutrients.add(nutrient);
      }
    });
    notifyListeners();
  }

  refreshAll() {
    notifyListeners();
  }

  remove(Nutrient nutrient) {
    listOfNutrients.remove(nutrient);
    notifyListeners();
  }
}
