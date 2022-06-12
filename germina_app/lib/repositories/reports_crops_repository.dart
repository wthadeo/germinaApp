import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:germina_app/models/reports/reportCrop.dart';
import 'package:http/http.dart' as http;

class ReportsCropsRepository extends ChangeNotifier {
  static List<ReportCrop> listOfReportsCrops = [];

  UnmodifiableListView<ReportCrop> get lista =>
      UnmodifiableListView(listOfReportsCrops);

  static Future<List<ReportCrop>> getReportCropsFromApi(var url) async {
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

  saveAll(List<ReportCrop> reportCrops) {
    // ignore: avoid_function_literals_in_foreach_calls
    reportCrops.forEach((crop) {
      if (!listOfReportsCrops.contains(crop)) listOfReportsCrops.add(crop);
    });
    notifyListeners();
  }

  refreshAll() {
    notifyListeners();
  }

  remove(ReportCrop reportCrop) {
    listOfReportsCrops.remove(reportCrop);
    notifyListeners();
  }
}
