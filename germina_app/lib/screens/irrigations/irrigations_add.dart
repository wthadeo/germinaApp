/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/device.dart';
import 'package:germina_app/models/hour.dart';
import 'package:germina_app/models/irrigation.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:germina_app/repositories/devices_repository.dart';
import 'package:germina_app/repositories/irrigations_repository.dart';
import 'package:germina_app/repositories/nutrients_repository.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class IrrigationsAdd extends StatefulWidget {
  const IrrigationsAdd({Key? key}) : super(key: key);

  @override
  _IrrigationsAddState createState() => _IrrigationsAddState();
}

class _IrrigationsAddState extends State<IrrigationsAdd> {
  late IrrigationsRepository irrigationsRep;
  List<Crop> currentCrops = CropsRepository.listOfCrops;
  List<Device> currentDevices = DevicesRepository.listOfDevices;
  List<Nutrient> currentNutrients = NutrientsRepository.listOfNutrients;
  late Crop cropChoosed = currentCrops[0];
  late Device deviceChosed = currentDevices[0];
  late Nutrient nutrientChosed = currentNutrients[0];
  List<Crop> cropsChoose = [];
  List<Sensor> sensorsChoose = [];
  List<Nutrient> nutrientsChoose = [];
  //************************************************************* */
  String name = 'New Irrigation';
  TimeOfDay initialHour = TimeOfDay(
      hour: int.parse(DateFormat('hh').format(DateTime.now())),
      minute: int.parse(DateFormat('mm').format(DateTime.now())));
  int minutesActive = 0;
  // ignore: unused_field
  static Hour hourToStop = Hour(hour: 0, minutes: 0);
  int flowRate = 0;
  double energyPrice = 0;
  bool isActive = true;
  bool isFinished = false;
  late Irrigation irrigationAdded;
  List<Irrigation> irrigations = IrrigationsRepository.listOfIrrigations;
  String initialHourText = "Hor??rio de In??cio";

  var url = homeIrrigUrl;
  var urlUpdateNutrients = homeNutrientsUrl;
  //************************************************************* */

  void _selectTime() async {
    //Fun????o para escolha da hora com relogio
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: initialHour,
    );
    if (newTime != null &&
        newTime.hour.toDouble() * 60 + newTime.minute.toDouble() >
            initialHour.hour.toDouble() * 60 + initialHour.minute.toDouble()) {
      setState(() {
        initialHour = newTime;
        initialHourText =
            "${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}";
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Hor??rio Inv??lido"),
            content: const Text("Horario de inicio deve ser maior que o atual"),
            actions: <Widget>[
              // define os bot??es na base do dialogo
              TextButton(
                child: const Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _selectTime();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    irrigationsRep = Provider.of<IrrigationsRepository>(context);

    final _itensCrop = currentCrops
        .map((crop) => MultiSelectItem<Crop>(crop, crop.name))
        .toList();

    final _itensNutrient = currentNutrients
        .map((nutrient) => MultiSelectItem<Nutrient>(nutrient, nutrient.name))
        .toList();

    final _itensSensor = currentSensors
        .map((sensor) => MultiSelectItem<Sensor>(sensor, sensor.name))
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Nova Irriga????o",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              //Campo Nome da Irriga????o
              //NOME DA IRRIGA????O
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    name = text; //por padr??o inicia new irrigation
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Nome',
                    hintText: 'Nome da Irriga????o',
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 6.0, right: 20.0, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: ElevatedButton(
                        //botao que leva a sele????o da hora de inicio
                        child: Text(initialHourText),
                        onPressed: _selectTime,
                        style: ElevatedButton.styleFrom(
                            onPrimary: const Color.fromRGBO(255, 255, 255, 1),
                            minimumSize: const Size(140, 50),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    //caixa para definir dura????o da irriga????o
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        minutesActive = int.parse(text);
                        // ignore: avoid_print
                        print(minutesActive.toString());
                      },
                      decoration: const InputDecoration(
                          labelText: 'Dura????o(min)',
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
                    //caixa para definir a vaz??o de litros por hora
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        flowRate = int.parse(text);
                        // ignore: avoid_print
                        print(flowRate.toString());
                      },
                      decoration: const InputDecoration(
                          labelText: 'Vaz??o(L/H)',
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
                        print(energyPrice.toString());
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
              child: MultiSelectDialogField(
                items: _itensCrop,
                title: const Text("Cultivos"),
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
                  "Escolher Cultivos",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  cropsChoose = [];
                  // ignore: avoid_function_literals_in_foreach_calls
                  results.forEach((crop) {
                    cropsChoose.add(crop as Crop);
                  });
                  // ignore: avoid_print
                  print(cropsChoose.toString());
                  //cropsChoose = results;
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 25, right: 25),
              child: MultiSelectDialogField(
                items: _itensSensor,
                title: const Text("Sensores"),
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
                  "Escolher Sensores",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  sensorsChoose = [];
                  // ignore: avoid_function_literals_in_foreach_calls
                  results.forEach((sensor) {
                    sensorsChoose.add(sensor as Sensor);
                  });
                  // ignore: avoid_print
                  print(sensorsChoose.toString());
                  //cropsChoose = results;
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 25, right: 25),
              child: MultiSelectDialogField(
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
              ),
            ),
            const SizedBox(
              height: 30,
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
                onPressed: () async {
                  irrigationAdded = Irrigation(
                      name: name,
                      startHour: initialHour.hour,
                      startMinutes: initialHour.minute,
                      timeToUse: minutesActive,
                      //fazer os calculos dos minutos e inicializar a hora de parar aqui
                      flowRate: flowRate,
                      energy: energyPrice,
                      crop: cropsChoose,
                      sensor: sensorsChoose,
                      nutrient: nutrientsChoose,
                      state: false,
                      isFinished: false,
                      listOfNotifications: []);
                  //atualizar os nutrientes, diminuindo a quantidade de nutrientes gastos aqui
                  irrigations.add(irrigationAdded);
                  // ignore: unused_local_variable
                  http.Response saveToDB = await saveToDb(
                      json.encode(irrigationAdded.toJson()), url);
                  irrigationsRep.saveAll(irrigations);
                  Navigator.pop(context);
                },
                child: const Text('Agendar Irriga????o'))
          ],
        ),
      ),
    );
  }
}

// FUN????ES PARA SALVAR E EDITAR NO DB
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
*/