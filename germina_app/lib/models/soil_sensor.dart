import 'package:germina_app/models/sensor.dart';

class SoilSensor extends Sensor {

  final int dataSoil;

  SoilSensor(this.dataSoil, {required String name,required String protocol, required String uri}) : super(name, protocol, uri);

}