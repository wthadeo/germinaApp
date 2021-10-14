import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
      body: bodyFactory(context),
    );
  }
}

Widget bodyFactory(dynamic context) {
  if (Communicator.currentSensor.category == 'tempSensor') {
    TempSensor tmp = Communicator.currentSensor as TempSensor;
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Temperatura Atual: ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                color: primaryColor,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
              height: 200.0,
              width: 200.0,
              child: Stack(children: [
                Center(
                    child:
                        Image.asset('lib/assets/images/sun_temperature.png')),
                Center(
                    child: Text(
                  tmp.temperature.toString() + 'ºC',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 30.0),
                )),
              ])),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Umidade do Ar Atual: ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                color: primaryColor,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
              height: 200.0,
              width: 200.0,
              child: Stack(children: [
                Center(
                    child:
                        Image.asset('lib/assets/images/umidity.png')),
                Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text(
                  tmp.umidity.toString() + '%',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 30.0, color: Colors.white),
                ),
                    )),
              ]))
        ],
      ),
    );
  } else {
    SoilSensor tmp = Communicator.currentSensor as SoilSensor;
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 80,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color:
                      primaryColor.withOpacity(tmp.dataSoil <= 70 ? 0.3 : 0.7),
                  value: tmp.dataSoil.toDouble(),
                  showTitle: false,
                  radius: 40,
                ),
                PieChartSectionData(
                  color: primaryColor.withOpacity(0.1),
                  value: (100 - tmp.dataSoil).toDouble(),
                  showTitle: false,
                  radius: 25,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Soil Moisture"),
                const SizedBox(height: 16.0),
                Text(
                  "${tmp.dataSoil}%",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: primaryColor.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
