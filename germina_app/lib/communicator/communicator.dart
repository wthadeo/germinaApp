import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/models/irrigation.dart';

class Communicator {

  static Sensor currentSensor = Sensor('', '', '', '');
  //static Irrigation currentIrrigator;
  static Crop currentCrop = Crop('', '', 0, true, []);
  //static Nutrient currentNutrient;
  //static Report currentReport;

}