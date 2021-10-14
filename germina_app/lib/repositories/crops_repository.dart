import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:germina_app/models/crop.dart';
import 'package:provider/provider.dart';

class CropsRepository extends ChangeNotifier{

  static List<Crop> listOfCrops = [
    Crop('Cultivo X', '14/10/2021', 2, true),
    Crop('Cultivo Y', '10/10/2021', 2, false),
  ];

  UnmodifiableListView<Crop> get lista => UnmodifiableListView(listOfCrops);

  saveAll(List<Crop> sensors){
    sensors.forEach((sensor) {
      if(!listOfCrops.contains(sensor)) listOfCrops.add(sensor);
     });
    notifyListeners();
  }

  remove(Crop sensor){
    listOfCrops.remove(sensor);
    notifyListeners();
  }

}