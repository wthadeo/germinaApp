import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/note.dart';

class CropsRepository extends ChangeNotifier {
  static List<Crop> listOfCrops = [
    Crop('Cultivo X', '05-10-2021', 2, true, []),
    Crop('Cultivo Y', '20-08-2021', 5, false, [
      Note('Obs1', 'LoremImpsun LoremIpsum Lorem', '2021-08-23'),
      Note('Obs2', 'LoremImpsun LoremIpsum Lorem', '2021-08-25'),
    ]),
  ];

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
