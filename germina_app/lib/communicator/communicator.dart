import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/models/irrigation.dart';

class Communicator {
  static Sensor currentSensor =
      Sensor(name: '', protocol: '', uri: '', category: '');
  static Irrigation currentIrrigator = Irrigation(
      name: '',
      dateOfCreation: '',
      startHour: '',
      timeToUse: 0,
      waterPrice: 0,
      flowRate: 0,
      energyPrice: 0,
      crop: [],
      device: [],
      nutrient: [],
      state: false,
      isFinished: false,
      listOfNotifications: []);
  static Crop currentCrop = Crop(
      name: '',
      dateOfCreation: '',
      age: '',
      qntOfPlants: 0,
      costOfCrop: 0,
      isActive: false,
      notesCrop: []);
  static Nutrient currentNutrient =
      Nutrient(name: '', priceMg: 0.0, totalAmount: 0, buysNutrient: []);
  //static Report currentReport;

}
