import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/note_nutrient.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/repositories/nutrients_repository.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NutrientInformation extends StatefulWidget {
  const NutrientInformation({Key? key}) : super(key: key);

  @override
  State<NutrientInformation> createState() => _NutrientInformationState();
}

class _NutrientInformationState extends State<NutrientInformation> {
  Nutrient currentNutrient = Communicator.currentNutrient;
  late NutrientsRepository nutrientsRep;

  int qntAdd = 0;
  double price = 0;

  List<NoteNutrient> addNutrientList = [];

  var url = homeNutrientsUrl;

  Future<http.Response> editNutrientDb(String crop, var url) async {
    final http.Response response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: crop);
    return response;
  }

  void refreshNotes() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    nutrientsRep = Provider.of<NutrientsRepository>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          currentNutrient.name,
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
              height: 160.0,
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
                            'Info',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'Nome: ' + currentNutrient.name,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'Quantidade Total : ' +
                          currentNutrient.totalAmount.toString() +
                          ' mg',
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'Valor/mg : R\$' +
                          currentNutrient.priceMg.toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                height: 340.0,
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
                              'Adi????es',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, left: 10.0, bottom: 10.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 260.0,
                          width: 400.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.separated(
                            itemBuilder: (BuildContext context, int note) {
                              return Column(
                                children: [
                                  Text(
                                    'Quantidade: ' +
                                        currentNutrient
                                            .buysNutrient[note].quantAdd
                                            .toString() +
                                        ' mg',
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Valor: R\$ ' +
                                        currentNutrient.buysNutrient[note].price
                                            .toStringAsFixed(2),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Data de Cadastro: ' +
                                        currentNutrient.buysNutrient[note].date,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              );
                            },
                            padding: const EdgeInsets.all(16),
                            separatorBuilder: (_, __) => const Divider(),
                            itemCount: currentNutrient.buysNutrient.length,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          NoteNutrient addnote;
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: <Widget>[
                      Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onChanged: (text) {
                                  qntAdd = int.parse(text);
                                },
                                decoration: const InputDecoration(
                                    hintText: 'quantidade em mg p/ adicionar'),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    if (text.contains(',')) {
                                      List<String> priceCorrection =
                                          text.split(',');
                                      String priceCorrected =
                                          priceCorrection[0] +
                                              '.' +
                                              priceCorrection[1];
                                      price = double.parse(priceCorrected);
                                    } else {
                                      price = double.parse(text);
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Valor R\$'),
                                  keyboardType: TextInputType.number,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: const Text("Adicionar"),
                                onPressed: () async {
                                  int qntidade =
                                      currentNutrient.totalAmount + qntAdd;
                                  double valorPago = recalcValor(
                                      currentNutrient.totalAmount,
                                      currentNutrient.priceMg,
                                      qntAdd,
                                      price);
                                  addnote = NoteNutrient(
                                      quantAdd: qntAdd,
                                      price: price,
                                      date: DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now())
                                          .toString());

                                  currentNutrient.totalAmount = qntidade;
                                  currentNutrient.priceMg = valorPago;
                                  currentNutrient.buysNutrient.add(addnote);

                                  // ignore: unused_local_variable
                                  http.Response editNutrient =
                                      await editNutrientDb(
                                          json.encode(currentNutrient.toJson()),
                                          url);
                                  nutrientsRep.refreshAll();
                                  Navigator.pop(context);
                                },
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
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

double recalcValor(int a, double b, int c, double d) {
  double valReais = a * b;
  int qntTotal = a + c;
  double valTotal = valReais + d;
  double resultado = valTotal / qntTotal;

  return resultado;
}
