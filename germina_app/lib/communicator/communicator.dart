import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/models/irrigation.dart';
import 'package:germina_app/models/hour.dart';

class Communicator {
  static Sensor currentSensor = Sensor('', '', '', '');
  static Irrigation currentIrrigator = Irrigation(
      '',
      Hour(0, 0),
      0,
      0,
      '',
      Crop('', '', 0, false, []),
      Sensor('', '', '', ''),
      Nutrient('', '', 0, 0.0),
      false);
  static Crop currentCrop = Crop('', '', 0, false, []);
  static Nutrient currentNutrient = Nutrient('', '', 0, 0.0);
  //static Report currentReport;

}
