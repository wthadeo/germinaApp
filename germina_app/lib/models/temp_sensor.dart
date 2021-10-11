import 'package:germina_app/models/sensor.dart';

class TempSensor extends Sensor {

  final int temperature;
  final int umidity;

  TempSensor(this.temperature, this.umidity, {required String name,required String protocol, required String uri}) : super(name, protocol, uri);

}