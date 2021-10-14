import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/models/sensors/soil_sensor.dart';
import 'package:germina_app/models/sensors/temp_sensor.dart';

class SensorInformation extends StatelessWidget {
  SensorInformation({Key? key}) : super(key: key);

  Sensor currentSensor = Communicator.currentSensor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          currentSensor.name,
          style: const TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: bodyFactory(),
    );
  }
}

Widget bodyFactory() {
  if(Communicator.currentSensor.category == 'tempSensor'){
    TempSensor tmp = Communicator.currentSensor as TempSensor;
    return Column(
      children: [
        Text(
          'Temperatura Atual: ' + tmp.temperature.toString()
        ),
        Text(
          'Umidade do Ar Atual: ' + tmp.umidity.toString()
        ),
      ],
    );
  } else {
    SoilSensor tmp = Communicator.currentSensor as SoilSensor;
    return Column(
      children: [
        Text(
          'Umidade do Solo: ' + tmp.dataSoil.toString()
        ),
      ]
    );
  };
}
