import 'package:flutter/material.dart';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: const Color.fromRGBO(66, 174, 181, 1),
  primary: const Color.fromRGBO(228, 241, 241, 8),
  minimumSize: const Size(88, 100),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

const Color primaryColor = Color.fromRGBO(66, 174, 181, 1);
const Color secondaryColor = Color.fromRGBO(115, 200, 215, 1);

var homeIrrigUrl = Uri.parse('http://192.168.0.113:3000/irrigations');
var homeCropsUrl = Uri.parse('http://192.168.0.113:3000/crops');
var homeCropsUrlConclude =
    Uri.parse('http://192.168.0.113:3000/crops/conclude');
var homeCropsUrlNote = Uri.parse('http://192.168.0.113:3000/crops/addNote');
var homeNutrientsUrl = Uri.parse('http://192.168.0.113:3000/nutrients');
var reportsCropsUrl = Uri.parse('http://192.168.0.113:3000/reportCrop');
var reportsIrrigationsUrl =
    Uri.parse('http://192.168.0.113:3000/reportIrrigation');
var reportsNutrientsUrl = Uri.parse('http://192.168.0.113:3000/reportNutrient');
Map<int, Color> color = {
  50: const Color.fromRGBO(66, 174, 181, .1),
  100: const Color.fromRGBO(66, 174, 181, .2),
  200: const Color.fromRGBO(66, 174, 181, .3),
  300: const Color.fromRGBO(66, 174, 181, .4),
  400: const Color.fromRGBO(66, 174, 181, .5),
  500: const Color.fromRGBO(66, 174, 181, .6),
  600: const Color.fromRGBO(66, 174, 181, .7),
  700: const Color.fromRGBO(66, 174, 181, .8),
  800: const Color.fromRGBO(66, 174, 181, .9),
  900: const Color.fromRGBO(66, 174, 181, 1),
};
