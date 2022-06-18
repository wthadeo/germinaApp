import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/irrigation.dart';
import 'package:germina_app/repositories/irrigations_repository.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class IrrigationInformation extends StatefulWidget {
  const IrrigationInformation({Key? key}) : super(key: key);

  @override
  _IrrigationInformationState createState() => _IrrigationInformationState();
}

class _IrrigationInformationState extends State<IrrigationInformation> {
  Irrigation currentIrrigation = Communicator.currentIrrigator;
  late IrrigationsRepository irrigationsRep;
  //List<Notification> listOfNotifications = currentIrrigation.listOfNotifications;

  @override
  Widget build(BuildContext context) {
    irrigationsRep = Provider.of<IrrigationsRepository>(context);

    var urlConclude =
        Uri.parse('http://192.168.0.113:3000/irrigations/conclude');
    var onOffEsp = Uri.parse('http://192.168.0.113:3000/esp32');
    var obj = {"name": "esp32", "drySoil": 0};

    Future<http.Response> editIrrigationDb(String crop, var url) async {
      final http.Response response = await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: crop);
      return response;
    }

    Widget finishButton(Irrigation currentIrrigation, var url) {
      if (currentIrrigation.state) {
        return ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        Form(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Deseja realmente concluir a irrigação?',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      child: const Text("Sim"),
                                      onPressed: () async {
                                        // ignore: unused_local_variable
                                        http.Response edit =
                                            await editIrrigationDb(
                                                json.encode(
                                                    currentIrrigation.toJson()),
                                                url);
                                        edit = await editIrrigationDb(
                                            json.encode(obj), onOffEsp);
                                        setState(() {
                                          Communicator.currentCrop.isActive =
                                              false;
                                        });
                                        irrigationsRep.refreshAll();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Text("Não"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: const Text('Concluir Irrigação'),
        );
      } else {
        return const ElevatedButton(
          onPressed: null,
          child: Text('Irrigação Concluída'),
        );
      }
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            currentIrrigation.name,
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                alignment: Alignment.center,
                height: 330.0,
                width: 400.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: 400.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const ListTile(
                            leading: Text(
                              'Informações do Cultivo',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Nome: ' + currentIrrigation.name,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Duração : ' +
                            currentIrrigation.timeToUse.toString() +
                            ' minutos',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Cultivo: ' + listOf(currentIrrigation.crop),
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Vazão: ' +
                            currentIrrigation.flowRate.toString() +
                            ' L/h',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Dispositivos: \n' + listOf(currentIrrigation.device),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Nutrientes: ' + listOf(currentIrrigation.nutrient),
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
              ),
            ),
            finishButton(currentIrrigation, urlConclude),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  height: 260.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Notificações',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              right: 10.0, left: 10.0, bottom: 10.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 180.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int note) {
                                return Column(
                                  children: const [
                                    Text(
                                      'Quantidade: ' /* +
                                          addNutrientList[note]
                                              .quantAdd
                                              .toString()*/
                                      ,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Valor: ' /*+
                                          addNutrientList[note]
                                              .price
                                              .toStringAsFixed(2)*/
                                      ,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Data de Cadastro: ' /*+
                                          DateFormat('dd-MM-yyyy')
                                              .format(
                                                  addNutrientList[note].date)
                                              .toString()*/
                                      ,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                );
                              },
                              padding: const EdgeInsets.all(16),
                              separatorBuilder: (_, __) => const Divider(),
                              itemCount: 0,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}

String isActive(bool isActive) {
  if (isActive) {
    return "Ativa";
  } else {
    return "Concluida";
  }
}

String listOf(List state) {
  String result = '';

  for (int i = 0; i < state.length; i++) {
    if (i < state.length - 1) {
      result = result + state[i].name + ' | ';
    } else {
      result = result + state[i].name;
    }
  }
  return result;
}
