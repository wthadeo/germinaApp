import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/note_nutrient.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:intl/intl.dart';

class NutrientInformation extends StatefulWidget {
  NutrientInformation({Key? key}) : super(key: key);

  @override
  State<NutrientInformation> createState() => _NutrientInformationState();
}

class _NutrientInformationState extends State<NutrientInformation> {
  Nutrient currentNutrient = Communicator.currentNutrient;

  int qntAdd = 0;
  double price = 0;

  List<NoteNutrient> addNutrientList = [];

  void refreshNotes(NoteNutrient note) {
    setState(() {
      addNutrientList.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              height: 200.0,
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
                      'Intervalo: ' + currentNutrient.interval,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'Quantidade Total : ' +
                          currentNutrient.totalAmount.toString(),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'Preço : R\$' + currentNutrient.priceMg.toString(),
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
                height: 300.0,
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
                              'Adições',
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
                          height: 220.0,
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
                                        addNutrientList[note].quantAdd.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Valor: ' +
                                        addNutrientList[note].price.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Data de Cadastro: ' +
                                        DateFormat('dd-MM-yyyy')
                                            .format(addNutrientList[note].date)
                                            .toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              );
                            },
                            padding: const EdgeInsets.all(16),
                            separatorBuilder: (_, __) => const Divider(),
                            itemCount: addNutrientList.length,
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
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
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
                                    hintText: 'quantidade p/ adicionar'),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(8.0),
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
                                  decoration:
                                      const InputDecoration(hintText: 'valor'),
                                  keyboardType: TextInputType.number,
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: const Text("Adicionar"),
                                onPressed: () {
                                  addnote = NoteNutrient(
                                      qntAdd, price, DateTime.now());
                                  refreshNotes(addnote);
                                  currentNutrient.totalAmount =
                                      currentNutrient.totalAmount + qntAdd;
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
