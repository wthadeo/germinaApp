import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/hour.dart';
import 'package:germina_app/models/notification.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/sensors/sensor.dart';

class Irrigation {
  String name;
  Hour startHour;
  int timeToUse;
  int flowRate;
  double energy;
  Crop crop;
  List<Sensor> sensor;
  List<Nutrient> nutrient;
  bool state;
  List<Notification> listOfNotifications;

  Irrigation(this.name, this.startHour, this.timeToUse, this.flowRate,
      this.energy, this.crop, this.sensor, this.nutrient, this.state, this.listOfNotifications);
}
