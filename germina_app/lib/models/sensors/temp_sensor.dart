import 'package:germina_app/models/sensors/sensor.dart';

class TempSensor extends Sensor {
  int temperature;
  int umidity;

  TempSensor(this.temperature, this.umidity,
      {required String name,
      required String protocol,
      required String uri,
      String category = 'tempSensor'})
      : super(name, protocol, uri, category);
}
