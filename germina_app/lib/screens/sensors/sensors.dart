import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/repositories/sensors_repository.dart';
import 'package:germina_app/screens/sensors/sensor_add.dart';
import 'package:germina_app/screens/sensors/sensor_information.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  static List<Sensor> sensors = SensorsRepository.listOfSensors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sensores",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: GridView.builder(
          itemCount: sensors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20),
          itemBuilder: (context, index) => SensorView(index, context)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const SensorAdd()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget SensorView(int index, dynamic context) {
  String name = _SensorsPageState.sensors[index].name;
  String category = _SensorsPageState.sensors[index].category;

  return GestureDetector(
    onTap: () {
      Communicator.currentSensor = SensorsRepository.listOfSensors[index];
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SensorInformation()));
    },
    child: Container(
      height: 300,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: categoryColor2(category),
        borderRadius: BorderRadius.circular(15),
      ),
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
    ),
  );
}

MaterialColor categoryColor(String category) {
  if (category == 'tempSensor') {
    return Colors.amber;
  } else {
    return Colors.blue;
  }
}

Color categoryColor2(String category) {
  if (category == 'tempSensor') {
    return Colors.amber;
  } else {
    return secondaryColor;
  }
}

// 3 SENSORES DE UMIDADE DO SOLO ()
// 1 SENSOR DE TEMPERATURA AMBIENTE/UMIDADE DO AR (DTH11)
