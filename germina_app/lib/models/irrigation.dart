import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/hour.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/sensors/sensor.dart';

class Irrigation {
  String name;
  Hour startHour;
  int timeToUse;
  int flowRate;
  String energy;
  Crop crop;
  Sensor sensor;
  Nutrient nutrient;
  bool state;

  Irrigation(this.name, this.startHour, this.timeToUse, this.flowRate,
      this.energy, this.crop, this.sensor, this.nutrient, this.state);
}
