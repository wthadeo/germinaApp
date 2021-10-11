import 'package:flutter/material.dart';
import 'package:germina_app/models/sensor.dart';
import 'package:germina_app/models/soil_sensor.dart';
import 'package:germina_app/models/temp_sensor.dart';
import 'package:germina_app/screens/sensors/sensor_add.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sensores",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: const Color.fromRGBO(66, 174, 181, 95),
      ),
      body: GridView.builder(
          itemCount: sensors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) => SensorView(index)),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SensorAdd()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget SensorView(int index) {
  String name = sensors[index].name;

  return Container(
    height: 50.0,
    width: 50.0,
    color: Colors.red,
    margin: const EdgeInsets.all(10.0),
    child: Center(
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ),
      ),
    ),
  );
}

List<Sensor> sensors = [
  SoilSensor(25,
      name: 'sensor_soil1', protocol: 'unknown protocol', uri: 'unknown uri'),
  SoilSensor(20,
      name: 'sensor_soil2', protocol: 'unknown protocol', uri: 'unknown uri'),
  SoilSensor(40,
      name: 'sensor_soil3', protocol: 'unknown protocol', uri: 'unknown uri'),
  TempSensor(36, 38,
      name: 'sensor_temperature1',
      protocol: 'unknown protocol',
      uri: 'unknown uri')
];
// 3 SENSORES DE UMIDADE DO SOLO ()
// 1 SENSOR DE TEMPERATURA AMBIENTE/UMIDADE DO AR (DTH11)
