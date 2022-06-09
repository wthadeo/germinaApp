import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/repositories/sensors_repository.dart';
import 'package:provider/provider.dart';
import '../../models/device.dart';
import '../../repositories/devices_repository.dart';
import '../sensors/sensors.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  late DevicesRepository devicesRep;
  static List<Device> devices = DevicesRepository.listOfDevices;

  @override
  Widget build(BuildContext context) {
    devicesRep = Provider.of<DevicesRepository>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Dispositivos",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: GridView.builder(
          itemCount: devices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 0.1,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) => SensorView(index, context)),
    );
  }
}

// ignore: non_constant_identifier_names
Widget SensorView(int index, dynamic context) {
  String name = _DevicesPageState.devices[index].name;

  return GestureDetector(
    onTap: () {
      Communicator.currentSensor = SensorsRepository.listOfSensors[index];
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const SensorsPage()));
    },
    child: Container(
      height: 300,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: secondaryColor,
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

// 3 SENSORES DE UMIDADE DO SOLO ()
// 1 SENSOR DE TEMPERATURA AMBIENTE/UMIDADE DO AR (DTH11)
