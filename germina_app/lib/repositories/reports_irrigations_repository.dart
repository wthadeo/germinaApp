import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:germina_app/models/reports/reportIrrigation.dart';
import 'package:http/http.dart' as http;

class ReportsIrrigationRepository extends ChangeNotifier {
  static List<ReportIrrigation> listOfReportsIrrigations = [];

  UnmodifiableListView<ReportIrrigation> get lista =>
      UnmodifiableListView(listOfReportsIrrigations);

  static Future<List<ReportIrrigation>> getReportIrrigationsFromApi(
      var url) async {
    http.Response res = await http.get((url));

    if (res.statusCode == 200) {
      List<dynamic> body = json.decode(res.body);

      List<ReportIrrigation> irrigations = body
          .map(
            (dynamic item) => ReportIrrigation.fromJson(item),
          )
          .toList();

      return irrigations;
    } else {
      throw "Unable to retrieve reports of irrigations.";
    }
  }

  saveAll(List<ReportIrrigation> reportIrrigations) {
    // ignore: avoid_function_literals_in_foreach_calls
    reportIrrigations.forEach((irrigation) {
      if (!listOfReportsIrrigations.contains(irrigation)) {
        listOfReportsIrrigations.add(irrigation);
      }
    });
    notifyListeners();
  }

  refreshAll() {
    notifyListeners();
  }

  remove(ReportIrrigation reportIrrigation) {
    listOfReportsIrrigations.remove(reportIrrigation);
    notifyListeners();
  }
}
