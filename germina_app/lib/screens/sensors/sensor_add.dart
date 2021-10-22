import 'package:flutter/material.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/models/sensors/soil_sensor.dart';
import 'package:germina_app/models/sensors/temp_sensor.dart';
import 'package:germina_app/repositories/sensors_repository.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class SensorAdd extends StatefulWidget {
  const SensorAdd({Key? key}) : super(key: key);

  @override
  _SensorAddState createState() => _SensorAddState();
}

class _SensorAddState extends State<SensorAdd> {
  late SensorsRepository sensorsRep;
  String name = '';
  String protocol = '';
  String uri = '';
  Sensor sensorAdded =
      Sensor(name:'', protocol: '', uri: '', category: ''); //Sensor que será adicionado a lista de sensores
  List<Sensor> sensors = SensorsRepository.listOfSensors;
  String dropdownValue = 'Tipo de Sensor';

  @override
  Widget build(BuildContext context) {
    sensorsRep = Provider.of<SensorsRepository>(context);

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
              height: 40.0,
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>[
                'Tipo de Sensor',
                'Sensor Temperatura/Umidade',
                'Sensor Umidade do Solo'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 160.0,
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
                  if (dropdownValue == 'Sensor Temperatura/Umidade') {
                    sensorAdded = TempSensor(0, 0,
                        name: name, protocol: protocol, uri: uri);
                    sensors.add(sensorAdded);
                    sensorsRep.saveAll(sensors);
                    Navigator.pop(context);
                  } else if (dropdownValue == 'Sensor Umidade do Solo') {
                    sensorAdded =
                        SoilSensor(0, name: name, protocol: protocol, uri: uri);
                    sensors.add(sensorAdded);
                    sensorsRep.saveAll(sensors);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Adicionar Sensor'))
          ],
        ),
      ),
    );
  }
}
