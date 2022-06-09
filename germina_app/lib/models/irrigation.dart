import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/device.dart';
import 'package:germina_app/models/notification.dart';
import 'package:germina_app/models/nutrient.dart';

class Irrigation {
  String name;
  String dateOfCreation;
  String startHour;
  int timeToUse;
  double waterPrice;
  int flowRate;
  double energyPrice;
  List<Crop> crop;
  List<Device> device;
  List<Nutrient> nutrient;
  bool state;
  bool isFinished;
  List<Notification> listOfNotifications;

  Irrigation(
      {required this.name,
      required this.dateOfCreation,
      required this.startHour,
      required this.timeToUse,
      required this.waterPrice,
      required this.flowRate,
      required this.energyPrice,
      required this.crop,
      required this.device,
      required this.nutrient,
      required this.state,
      required this.isFinished,
      required this.listOfNotifications});

  double waterExpenses(double waterPrice, int duration, int flowRate) {
    double result;

    result = (((duration / 60) * flowRate) / 1000) * waterPrice;

    return result;
  }

  double energyExpenses(double energyPrice, int duration) {
    double result;

    result = (duration / 60) * energyPrice;

    return result;
  }

  double nutrientExpenses(List<Nutrient> nutrients, List<int> values) {
    return 200;
  }

  factory Irrigation.fromJson(Map<String, dynamic> json) {
    var listCrops = json['crop'] as List;
    var listDevices = json['device'] as List;
    var listNutrients = json['nutrient'] as List;

    List<Crop> _crops = listCrops.map((v) => Crop.fromJson(v)).toList();
    List<Device> _devices = listDevices.map((v) => Device.fromJson(v)).toList();
    List<Nutrient> _nutrients =
        listNutrients.map((v) => Nutrient.fromJson(v)).toList();
    List<Notification> _notifications = [];

    return Irrigation(
        name: json['name'],
        dateOfCreation: json['dateOfCreation'],
        startHour: json['startHour'],
        timeToUse: json['timeToUse'],
        waterPrice: json['waterPrice'].toDouble(),
        flowRate: json['flowRate'],
        energyPrice: json['energyPrice'].toDouble(),
        crop: _crops,
        device: _devices,
        nutrient: _nutrients,
        state: json['state'],
        isFinished: json['isFinished'],
        listOfNotifications: _notifications);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['dateOfCreation'] = dateOfCreation;
    data['startHour'] = startHour;
    data['timeToUse'] = timeToUse;
    data['waterPrice'] = waterPrice;
    data['flowRate'] = flowRate;
    data['energyPrice'] = energyPrice;
    data['crop'] = crop.map((v) => v.toJson()).toList();
    data['device'] = device.map((v) => v.toJson()).toList();
    data['nutrient'] = nutrient.map((v) => v.toJson()).toList();
    data['state'] = state;
    data['isFinished'] = isFinished;
    data['listOfNotifications'] = [];
    return data;
  }
}
