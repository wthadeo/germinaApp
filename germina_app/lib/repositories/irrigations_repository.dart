import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:germina_app/models/irrigation.dart';
import 'package:http/http.dart' as http;


class IrrigationsRepository extends ChangeNotifier {
  static List<Irrigation> listOfIrrigations = [];

  static Future<List<Irrigation>> getIrrigationsFromApi(var url) async {
  http.Response res = await http.get((url));

  if (res.statusCode == 200) {
    List<dynamic> body = json.decode(res.body);

    List<Irrigation> irrigations = body
        .map(
          (dynamic item) => Irrigation.fromJson(item),
        )
        .toList();

    return irrigations;
  } else {
    throw "Unable to retrieve irrigations.";
  }
}

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

  refreshAll(){
    notifyListeners();
  }

  remove(Irrigation irrigation) {
    listOfIrrigations.remove(irrigation);
    notifyListeners();
  }
}
