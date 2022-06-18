import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/repositories/sensors_repository.dart';
import 'package:germina_app/screens/sensors/sensor_add.dart';
import 'package:germina_app/screens/sensors/sensor_information.dart';
import 'package:more4iot_dart_api/more4iot_dart_api.dart';
import 'package:provider/provider.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  late SensorsRepository sensorsRep;
  static List<Sensor> sensors = SensorsRepository.listOfSensors;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final more4iot = More4iotMqtt(host: '192.168.0.113');
      more4iot.connect(germina, 'application');
    });
  }

  @override
  Widget build(BuildContext context) {
    sensorsRep = Provider.of<SensorsRepository>(context);

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
              childAspectRatio: 1.4,
              crossAxisSpacing: 0.1,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) => SensorView(index, context)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const SensorAdd()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void germina(Scope scope) {
    final soilMoisture = scope.getData<int>('soil-moisture');
    final temperature = scope.getData<int>('temperature');
    final humidity = scope.getData<int>('humidity');
    //final drySoil = scope.getCommand<int>('dry-soil');

    // ignore: avoid_print
    print('SCOPE: $soilMoisture  $temperature  $humidity  ');

    if (mounted) {
      setState(() {
        Communicator.soilMoisture = soilMoisture;
        Communicator.temperature = temperature;
        Communicator.umidity = humidity;
        //Communicator.drySoil = drySoil;
      });
    }
  }
}

// ignore: non_constant_identifier_names
Widget SensorView(int index, dynamic context) {
  String name = _SensorsPageState.sensors[index].name;
  String category = _SensorsPageState.sensors[index].category;

  return GestureDetector(
    onTap: () {
      Communicator.currentSensor = SensorsRepository.listOfSensors[index];
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SensorInformation()));
    },
    child: Container(
      height: 300,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: categoryColor(category),
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

Color categoryColor(String category) {
  if (category == 'tempSensor') {
    return Colors.amber;
  } else {
    return secondaryColor;
  }
}

// 3 SENSORES DE UMIDADE DO SOLO ()
// 1 SENSOR DE TEMPERATURA AMBIENTE/UMIDADE DO AR (DTH11)
