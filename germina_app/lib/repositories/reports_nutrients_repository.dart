import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:germina_app/models/reports/reportCrop.dart';
import 'package:http/http.dart' as http;

class ReportsNutrientsRepository extends ChangeNotifier {
  static List<ReportCrop> listOfReportsNutrients = [];

  UnmodifiableListView<ReportCrop> get lista =>
      UnmodifiableListView(listOfReportsNutrients);

  static Future<List<ReportCrop>> getReportNutrientsFromApi(var url) async {
    http.Response res = await http.get((url));

    if (res.statusCode == 200) {
      List<dynamic> body = json.decode(res.body);

      List<ReportCrop> crops = body
          .map(
            (dynamic item) => ReportCrop.fromJson(item),
          )
          .toList();

      return crops;
    } else {
      throw "Unable to retrieve crops.";
    }
  }

  saveAll(List<ReportCrop> reportNutrients) {
    // ignore: avoid_function_literals_in_foreach_calls
    reportNutrients.forEach((nutrient) {
      if (!listOfReportsNutrients.contains(nutrient)) {
        listOfReportsNutrients.add(nutrient);
      }
    });
    notifyListeners();
  }

  refreshAll() {
    notifyListeners();
  }

  remove(ReportCrop reportNutrients) {
    listOfReportsNutrients.remove(reportNutrients);
    notifyListeners();
  }
}
