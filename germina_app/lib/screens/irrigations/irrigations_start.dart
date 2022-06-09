import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/device.dart';
import 'package:germina_app/models/irrigation.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/reports/reportCrop.dart';
import 'package:germina_app/models/reports/reportIrrigation.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:germina_app/repositories/devices_repository.dart';
import 'package:germina_app/repositories/irrigations_repository.dart';
import 'package:germina_app/repositories/nutrients_repository.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IrrigationsStart extends StatefulWidget {
  const IrrigationsStart({Key? key}) : super(key: key);

  @override
  _IrrigationsStartState createState() => _IrrigationsStartState();
}

class _IrrigationsStartState extends State<IrrigationsStart> {
  late IrrigationsRepository irrigationsRep;
  List<Crop> currentCrops = CropsRepository.listOfCrops;
  List<Device> currentDevices = DevicesRepository.listOfDevices;
  List<Nutrient> currentNutrients = NutrientsRepository.listOfNutrients;
  late Crop cropChoosed = currentCrops[0];
  late Device deviceChosed = currentDevices[0];
  late Nutrient nutrientChosed = currentNutrients[0];
  //************************************************************* */
  String name = 'New Irrigation';
  final dateOfCreation = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String initialHour = DateFormat('Hm').format(DateTime.now());
  int duration = 0;
  double waterPrice = 0;
  int flowRate = 0;
  double energyPrice = 0;
  List<Crop> cropsChoose = [];
  List<Device> devicesChoose = [];
  List<Nutrient> nutrientsChoose = [];
  List<Nutrient> tempNut = [];
  List<int> tempqnt = [];
  bool isActive = true;
  bool isFinished = false;
  Irrigation irrigationAdded = Irrigation(
      name: '',
      dateOfCreation: '',
      startHour: '',
      timeToUse: 0,
      waterPrice: 0,
      flowRate: 0,
      energyPrice: 0,
      crop: [],
      device: [],
      nutrient: [],
      state: false,
      isFinished: false,
      listOfNotifications: []);
  List<Irrigation> irrigations = IrrigationsRepository.listOfIrrigations;
  String initialHourText = "Horário de Início";

  var url = homeIrrigUrl;
  var urlUpdateNutrients = homeNutrientsUrl;
  var urlCropReport = Uri.parse('http://192.168.0.113:3000/reportCrop');
  var urlIrrigationReport =
      Uri.parse('http://192.168.0.113:3000/reportIrrigation');
  int qntNutriente = 0;
  bool buttonNewNutrient = true;
  bool buttonFinishNutrient = true;
  double nutrientPrice = 0;
  ReportCrop cropReport = ReportCrop(description: '', date: '', value: 0);
  ReportIrrigation irrigationReport = ReportIrrigation(
      description: '',
      date: '',
      cropUsed: '',
      waterSpended: 0,
      energySpended: 0,
      nutrientSpended: 0,
      totalSpended: 0);
  //************************************************************* */

  List<Widget> test = [];

  @override
  Widget build(BuildContext context) {
    irrigationsRep = Provider.of<IrrigationsRepository>(context);

    var _itemsCrop = currentCrops.map((crop) {
      return DropdownMenuItem<Crop>(
        child: Text(crop.name),
        value: crop,
      );
    }).toList();

    var _itemsDevice = currentDevices.map((device) {
      return DropdownMenuItem<Device>(
        child: Text(device.name),
        value: device,
      );
    }).toList();

    var _itemsNutrient = currentNutrients.map((nutrient) {
      return DropdownMenuItem<Nutrient>(
        child: Text(nutrient.name),
        value: nutrient,
      );
    }).toList();

    Widget listNutrients() {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: DropdownButton<Nutrient>(
                isExpanded: true,
                items: _itemsNutrient,
                onChanged: (newVal) => setState(() {
                  nutrientChosed = newVal!;
                  nutrientsChoose.clear();
                  nutrientsChoose.add(nutrientChosed);
                  print(nutrientsChoose[0].name);
                }),
                value: nutrientChosed,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  qntNutriente = int.parse(text);
                  // ignore: avoid_print
                  print(flowRate.toString());
                },
                decoration: const InputDecoration(
                    labelText: 'Quantidade mg',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    )),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
      ]);
    }

    if (test.isEmpty) {
      test.add(listNutrients());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Nova Irrigação",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              //Campo Nome da Irrigação
              //NOME DA IRRIGAÇÃO
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    name = text; //por padrão inicia new irrigation
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Nome',
                    hintText: 'Nome da Irrigação',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    //caixa para definir a vazão de litros por hora
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        duration = int.parse(text);
                        // ignore: avoid_print
                        print(flowRate.toString());
                      },
                      decoration: const InputDecoration(
                          labelText: 'Duração(min)',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    //caixa para inserir valor da energia em kwh
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        if (text.contains(',')) {
                          List<String> priceCorrection = text.split(',');
                          String priceCorrected =
                              priceCorrection[0] + '.' + priceCorrection[1];
                          energyPrice = double.parse(priceCorrected);
                        } else {
                          energyPrice = double.parse(text);
                        }
                        // ignore: avoid_print
                        print(waterPrice.toString());
                      },
                      decoration: const InputDecoration(
                          labelText: 'Valor Energia (kWh)',
                          hintText: 'R\$',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    //caixa para definir a vazão de litros por hora
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        flowRate = int.parse(text);
                        // ignore: avoid_print
                        print(flowRate.toString());
                      },
                      decoration: const InputDecoration(
                          labelText: 'Vazão(L/H)',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    //caixa para inserir valor da energia em kwh
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        if (text.contains(',')) {
                          List<String> priceCorrection = text.split(',');
                          String priceCorrected =
                              priceCorrection[0] + '.' + priceCorrection[1];
                          waterPrice = double.parse(priceCorrected);
                        } else {
                          waterPrice = double.parse(text);
                        }
                        // ignore: avoid_print
                        print(energyPrice.toString());
                      },
                      decoration: const InputDecoration(
                          labelText: 'Valor Água (m³)',
                          hintText: 'R\$',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Cultivo',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.5,
                    color: primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 25, right: 25),
              child: DropdownButton<Crop>(
                isExpanded: true,
                items: _itemsCrop,
                onChanged: (newVal) => setState(() {
                  cropChoosed = newVal!;
                  cropsChoose.clear();
                  cropsChoose.add(cropChoosed);
                }),
                value: cropChoosed,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Dispositivo',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.5,
                    color: primaryColor),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 25, right: 25),
              child: DropdownButton<Device>(
                isExpanded: true,
                items: _itemsDevice,
                value: deviceChosed,
                onChanged: (newVal) => setState(() {
                  deviceChosed = newVal!;
                  devicesChoose.clear();
                  devicesChoose.add(deviceChosed);
                }),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Nutrientes',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.5,
                    color: primaryColor),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 25, right: 25),
                child: Column(children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return test[index];
                    },
                    itemCount: test.length,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: !buttonFinishNutrient
                            ? null
                            : () async {
                                tempNut.add(nutrientChosed);
                                tempqnt.add(qntNutriente);
                                print(tempNut);
                                print(tempqnt);
                                nutrientChosed.totalAmount =
                                    nutrientChosed.totalAmount - qntNutriente;

                                if (buttonNewNutrient) {
                                  buttonNewNutrient = !buttonNewNutrient;
                                }
                                buttonFinishNutrient = !buttonFinishNutrient;
                                nutrientPrice = nutrientPrice +
                                    (nutrientChosed.priceMg * qntNutriente);
                                print(nutrientPrice);

                                http.Response editNutrient = await editDb(
                                    json.encode(nutrientChosed.toJson()),
                                    urlUpdateNutrients);
                                setState(() {});
                              },
                        child: const Text(
                          "Finalizar nutrientes",
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: !buttonNewNutrient
                            ? null
                            : () async {
                                test.add(listNutrients());
                                tempNut.add(nutrientChosed);
                                tempqnt.add(qntNutriente);
                                print(tempNut);
                                print(tempqnt);
                                nutrientChosed.totalAmount =
                                    nutrientChosed.totalAmount - qntNutriente;
                                if (test.length >= currentNutrients.length) {
                                  buttonNewNutrient = !buttonNewNutrient;
                                }
                                nutrientPrice = nutrientPrice +
                                    (nutrientChosed.priceMg * qntNutriente);
                                print(nutrientPrice);
                                http.Response editNutrient = await editDb(
                                    json.encode(nutrientChosed.toJson()),
                                    urlUpdateNutrients);
                                setState(() {});
                              },
                        child: const Text(
                          "Novo nutriente",
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      )
                    ],
                  )
                ])),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                //Finalizar irrigação
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: primaryColor,
                    minimumSize: const Size(300, 60),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onPressed: () async {
                  irrigationAdded = Irrigation(
                      name: name,
                      dateOfCreation: dateOfCreation.toString(),
                      startHour: initialHour.toString(),
                      timeToUse: duration,
                      waterPrice: waterPrice,
                      flowRate: flowRate,
                      energyPrice: energyPrice,
                      crop: cropsChoose,
                      device: devicesChoose,
                      nutrient: tempNut,
                      state: false,
                      isFinished: false,
                      listOfNotifications: []);
                  energyPrice =
                      irrigationAdded.energyExpenses(energyPrice, duration);
                  waterPrice = irrigationAdded.waterExpenses(
                      waterPrice, duration, flowRate);

                  cropReport = ReportCrop(
                      description: cropChoosed.name,
                      date: dateOfCreation,
                      value: energyPrice + waterPrice + nutrientPrice);

                  irrigationReport = ReportIrrigation(
                      description: name,
                      date: dateOfCreation,
                      cropUsed: cropChoosed.name,
                      waterSpended: waterPrice,
                      energySpended: energyPrice,
                      nutrientSpended: nutrientPrice,
                      totalSpended: energyPrice + waterPrice + nutrientPrice);

                  if (cropsChoose.isEmpty ||
                      devicesChoose.isEmpty ||
                      nutrientsChoose.isEmpty ||
                      duration == 0 ||
                      waterPrice == 0 ||
                      flowRate == 0 ||
                      energyPrice == 0) {
                    // ignore: prefer_const_constructors
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Campos sem preenchimento'),
                              content: SingleChildScrollView(
                                  child: ListBody(
                                children: const [
                                  Text(
                                    'Algum dos campos está sem preenchimento.',
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                      'Para prosseguir preencha todos os campos!',
                                      textAlign: TextAlign.center)
                                ],
                              )),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Ok!'))
                              ],
                            ));
                  } else {
                    irrigations.add(irrigationAdded);
                    // ignore: unused_local_variable
                    http.Response saveToDB = await saveToDb(
                        json.encode(irrigationAdded.toJson()), url);
                    saveToDB = await saveToDb(
                        json.encode(cropReport.toJson()), urlCropReport);
                    saveToDB = await saveToDb(
                        json.encode(irrigationReport.toJson()),
                        urlIrrigationReport);
                    irrigationsRep.saveAll(irrigations);
                    Navigator.pop(context);
                    //atualizar os nutrientes, diminuindo a quantidade de nutrientes gastos aqui
                  }
                },
                child: const Text('Iniciar Irrigação'))
          ],
        ),
      ),
    );
  }
}

// FUNÇÕES PARA SALVAR E EDITAR NO DB
Future<http.Response> saveToDb(String irrigation, var url) async {
  final http.Response response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: irrigation);
  return response;
}

Future<http.Response> editDb(String object, var url) async {
  final http.Response response = await http.put(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: object);
  return response;
}

/* 

    final _itensNutrient = currentNutrients
        .map((nutrient) => MultiSelectItem<Nutrient>(nutrient, nutrient.name))
        .toList();



MultiSelectDialogField(
                items: _itensNutrient,
                title: const Text("Nutrients"),
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  "Escolher Nutrientes",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  nutrientsChoose = [];
                  // ignore: avoid_function_literals_in_foreach_calls
                  results.forEach((nutrient) {
                    nutrientsChoose.add(nutrient as Nutrient);
                  });
                  // ignore: avoid_print
                  print(nutrientsChoose.toString());
                  //cropsChoose = results;
                },
              ),*/