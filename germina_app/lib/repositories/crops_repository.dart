import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/note.dart';

class CropsRepository extends ChangeNotifier {
  static List<Crop> listOfCrops = [];

  UnmodifiableListView<Crop> get lista => UnmodifiableListView(listOfCrops);

  saveAll(List<Crop> crops) {
    crops.forEach((crop) {
      if (!listOfCrops.contains(crop)) listOfCrops.add(crop);
    });
    notifyListeners();
  }

  saveNote(Note note, Crop currentCrop){
    currentCrop.notesCrop.add(note);
    notifyListeners();
  }

  remove(Crop crop) {
    listOfCrops.remove(crop);
    notifyListeners();
  }
}
