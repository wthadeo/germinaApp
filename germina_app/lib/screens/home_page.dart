import 'package:flutter/material.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:germina_app/repositories/irrigations_repository.dart';
import 'package:germina_app/repositories/nutrients_repository.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var urlIrrigations = homeIrrigUrl;
  var urlCrops = homeCropsUrl;
  var urlNutrients = homeNutrientsUrl;

  // ignore: prefer_typing_uninitialized_variables
  late final dataFromApi;

  /*int _soilMoisture = 0;
  int _drySoil = 0;
  double _temperature = 0;
  double _humidity = 0;

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final more4iot = More4iotMqtt(host: '192.168.0.113');
      more4iot.connect(germina, 'application');
    });
  }

  void germina(Scope scope) {
    final soilMoisture = scope.getData<int>('soil-moisture');
    final temperature = scope.getData<double>('temperature');
    final humidity = scope.getData<double>('humidity');
    final drySoil = scope.getCommand<int>('dry-soil');

    print('SCOPE: $soilMoisture  $temperature  $humidity  $drySoil');

    setState(() {
      _soilMoisture = soilMoisture;
      _temperature = temperature;
      _humidity = humidity;
      _drySoil = drySoil;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "GerminaApp",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder(
        future: dataFromApi = Future.wait([
          IrrigationsRepository.getIrrigationsFromApi(urlIrrigations),
          CropsRepository.getCropsFromApi(urlCrops),
          NutrientsRepository.getNutrientsFromApi(urlNutrients)
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            IrrigationsRepository.listOfIrrigations = snapshot.data?[0]!;
            CropsRepository.listOfCrops = snapshot.data?[1]!;
            NutrientsRepository.listOfNutrients = snapshot.data?[2]!;
            /*SensorsRepository.listOfSensors = [
              SoilSensor(_soilMoisture,
                  name: 'sensor_soil',
                  protocol: 'mqtt',
                  uri: 'unknown uri',
                  category: 'soilSensor'),
              TempSensor(
                _temperature,
                _humidity,
                name: 'sensor_temperature',
                protocol: 'mqtt',
                uri: 'unknown uri',
              )
            ];*/
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buttonMenu('Sensores', context, '/sensors'),
                  buttonMenu('Cultivos', context, '/crops'),
                  buttonMenu('Nutrientes', context, '/nutrients'),
                  buttonMenu('Irrigações', context, '/irrigations'),
                  buttonMenu('Relatórios', context, '/reports'),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Widget buttonMenu(String title, dynamic context, String nextPage) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          child: ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                Navigator.pushNamed(context, nextPage);
              },
              child: Text(title)),
        ),
      ),
    ],
  );
}
