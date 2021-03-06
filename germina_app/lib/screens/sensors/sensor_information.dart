import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/models/sensors/soil_sensor.dart';
import 'package:germina_app/models/sensors/temp_sensor.dart';

class SensorInformation extends StatefulWidget {
  const SensorInformation({Key? key}) : super(key: key);

  @override
  State<SensorInformation> createState() => _SensorInformationState();
}

class _SensorInformationState extends State<SensorInformation> {
  Sensor currentSensor = Communicator.currentSensor;

  /*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final more4iot = More4iotMqtt(host: '192.168.0.113');
      more4iot.connect(germina, 'application');
    });
  }*/

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

  /*void germina(Scope scope) {
    final soilMoisture = scope.getData<int>('soil-moisture');
    final temperature = scope.getData<int>('temperature');
    final humidity = scope.getData<int>('humidity');
    //final drySoil = scope.getCommand<int>('dry-soil');

    // ignore: avoid_print
    print('SCOPE: $soilMoisture  $temperature  $humidity  ');

    setState(() {
      Communicator.soilMoisture = soilMoisture;
      Communicator.temperature = temperature;
      Communicator.umidity = humidity;
      //_drySoil = drySoil;
    });
  }*/

  Widget bodyFactory(dynamic context) {
    if (Communicator.currentSensor.category == 'tempSensor') {
      TempSensor tmp = Communicator.currentSensor as TempSensor;
      tmp.temperature = Communicator.temperature;
      tmp.umidity = Communicator.umidity;
      //dispose();
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
                    tmp.temperature.toString() + '??C',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 30.0),
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
                  Center(child: Image.asset('lib/assets/images/umidity.png')),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Text(
                      tmp.umidity.toString() + '%',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30.0,
                          color: Colors.white),
                    ),
                  )),
                ]))
          ],
        ),
      );
    } else {
      //dispose();
      SoilSensor soil = Communicator.currentSensor as SoilSensor;
      soil.dataSoil = Communicator.soilMoisture;

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
                    color: primaryColor
                        .withOpacity(soil.dataSoil <= 70 ? 0.3 : 0.7),
                    value: soil.dataSoil.toDouble(),
                    showTitle: false,
                    radius: 40,
                  ),
                  PieChartSectionData(
                    color: primaryColor.withOpacity(0.1),
                    value: (100 - soil.dataSoil).toDouble(),
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
                    "${soil.dataSoil}%",
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
}
