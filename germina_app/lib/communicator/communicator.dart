import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/models/irrigation.dart';
import 'package:germina_app/models/hour.dart';

class Communicator {
  static Sensor currentSensor =
      Sensor(name: '', protocol: '', uri: '', category: '');
  static Irrigation currentIrrigator = Irrigation(
      name: '',
      startHour: Hour(0, 0),
      timeToUse: 0,
      flowRate: 0,
      energy: 0,
      crop: Crop(
          name: '', age: '', qntOfPlants: 0, isActive: false, notesCrop: []),
      sensor: [],
      nutrient: [],
      state: false,
      listOfNotifications: []);
  static Crop currentCrop =
      Crop(name: '', age: '', qntOfPlants: 0, isActive: false, notesCrop: []);
  static Nutrient currentNutrient =
      Nutrient(name: '', priceMg: 0.0, totalAmount: 0);
  //static Report currentReport;

}
