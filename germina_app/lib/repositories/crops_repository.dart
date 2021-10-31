import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/note.dart';
import 'package:http/http.dart' as http;

class CropsRepository extends ChangeNotifier {
  static List<Crop> listOfCrops = [];

  UnmodifiableListView<Crop> get lista => UnmodifiableListView(listOfCrops);

  static Future<List<Crop>> getCropsFromApi(var url) async {
    http.Response res = await http.get((url));

    if (res.statusCode == 200) {
      List<dynamic> body = json.decode(res.body);

      List<Crop> crops = body
          .map(
            (dynamic item) => Crop.fromJson(item),
          )
          .toList();

      return crops;
    } else {
      throw "Unable to retrieve crops.";
    }
  }

  saveAll(List<Crop> crops) {
    crops.forEach((crop) {
      if (!listOfCrops.contains(crop)) listOfCrops.add(crop);
    });
    notifyListeners();
  }

  saveNote(Note note, Crop currentCrop) {
    currentCrop.notesCrop.add(note);
    notifyListeners();
  }

  remove(Crop crop) {
    listOfCrops.remove(crop);
    notifyListeners();
  }
}
