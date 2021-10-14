import 'package:flutter/material.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/models/sensors/temp_sensor.dart';
import 'package:germina_app/repositories/sensors_repository.dart';
import '../../constants.dart';

class SensorAdd extends StatefulWidget {
  const SensorAdd({Key? key}) : super(key: key);

  @override
  _SensorAddState createState() => _SensorAddState();
}

class _SensorAddState extends State<SensorAdd> {
  String name = '';
  String protocol = '';
  String uri = '';
  Sensor sensorAdded =
      Sensor('', '', '', ''); //Sensor que será adicionado a lista de sensores
  List<Sensor> sensors = SensorsRepository.listOfSensors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Novo Sensor",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    name = text;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Nome',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    protocol = text;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Protocolo',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    uri = text;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'URI',
                  )),
            ),
            const SizedBox(
              height: 200.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: primaryColor,
                    minimumSize: const Size(300, 60),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onPressed: () {
                  sensorAdded = TempSensor(0, 0,
                      name: name, protocol: protocol, uri: uri);
                  SensorsRepository.listOfSensors.add(sensorAdded);
                  print(SensorsRepository.listOfSensors);
                },
                child: const Text('Adicionar Sensor'))
          ],
        ),
      ),
    );
  }
}
