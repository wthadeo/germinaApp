import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:germina_app/models/device.dart';
import 'package:germina_app/models/sensors/soil_sensor.dart';
import 'package:germina_app/models/sensors/temp_sensor.dart';

class DevicesRepository extends ChangeNotifier {
  static List<Device> listOfDevices = [
    Device(
        name: 'Esp32',
        uri: 'application',
        protocol: 'mqtt',
        sensors: [
          SoilSensor(0,
              name: 'sensor_soil',
              protocol: 'mqtt',
              uri: 'unknown uri',
              category: 'soilSensor'),
          TempSensor(
            0,
            0,
            name: 'sensor_temperature',
            protocol: 'mqtt',
            uri: 'unknown uri',
          )
        ],
        longitude: '',
        latitude: '')
  ];

  UnmodifiableListView<Device> get lista => UnmodifiableListView(listOfDevices);

  saveAll(List<Device> sensors) {
    // ignore: avoid_function_literals_in_foreach_calls
    sensors.forEach((sensor) {
      if (!listOfDevices.contains(sensor)) listOfDevices.add(sensor);
    });
    notifyListeners();
  }

  refreshAll() {
    notifyListeners();
  }

  remove(Device device) {
    listOfDevices.remove(device);
    notifyListeners();
  }
}
