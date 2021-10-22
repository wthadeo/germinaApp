import 'package:germina_app/models/sensors/sensor.dart';

class SoilSensor extends Sensor {
  int dataSoil;

  SoilSensor(this.dataSoil,
      {required String name,
      required String protocol,
      required String uri,
      String category = 'soilSensor'})
      : super(name: name,protocol: protocol,uri: uri,category: category);
}
