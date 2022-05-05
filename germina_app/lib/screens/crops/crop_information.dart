import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/note.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CropInformation extends StatefulWidget {
  CropInformation({Key? key}) : super(key: key);

  @override
  State<CropInformation> createState() => _CropInformationState();
}

class _CropInformationState extends State<CropInformation> {
  late CropsRepository cropsRep;
  Crop currentCrop = Communicator.currentCrop;

  List<Note> notesCrop = Communicator.currentCrop.notesCrop;
  String nameNote = '';
  String descriptionNote = '';

  var urlConclude = Uri.parse('http://192.168.0.113:3000/crops/conclude');
  var urlNote = Uri.parse('http://192.168.0.113:3000/crops/addNote');

  Future<http.Response> editCropDb(String crop, var url) async {
    final http.Response response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: crop);
    return response;
  }

  void refreshNotes(Note note) {
    setState(() {
      Communicator.currentCrop.notesCrop.add(note);
    });
  }

  Widget finishButton(Crop currentCrop, var url) {
    if (currentCrop.isActive) {
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
                                'Deseja realmente concluir o cultivo? Esta opção será permanente!',
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
                                      http.Response edit = await editCropDb(
                                          json.encode(currentCrop.toJson()),
                                          url);
                                      setState(() {
                                        Communicator.currentCrop.isActive =
                                            false;
                                      });
                                      cropsRep.refreshAll();
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
        child: const Text('Concluir Cultivo'),
      );
    } else {
      return const ElevatedButton(
        onPressed: null,
        child: Text('Cultivo Concluído'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    cropsRep = Provider.of<CropsRepository>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          currentCrop.name,
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
                            'Informações',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'Nome: ' + currentCrop.name,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'Data de Inserção: ' + currentCrop.age,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'Idade do Cultivo : ' +
                          calculateAge(currentCrop.age) +
                          ' dias',
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      'Quantidade de Plantas : ' +
                          currentCrop.qntOfPlants.toString(),
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ),
          ),
          finishButton(Communicator.currentCrop, urlConclude),
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
                              'Observações',
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
                                    'Observação: ' + notesCrop[note].name,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Descrição: ' + notesCrop[note].description,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Data de Cadastro: ' + notesCrop[note].date,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              );
                            },
                            padding: const EdgeInsets.all(16),
                            separatorBuilder: (_, __) => const Divider(),
                            itemCount: notesCrop.length,
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
          Note addnote;
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
                                  nameNote = (text);
                                },
                                decoration: const InputDecoration(
                                    hintText: 'Nome Observação'),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged: (text) {
                                    descriptionNote = text;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'Descrição'),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: const Text("Adicionar"),
                                onPressed: () async {
                                  addnote = Note(
                                      name: nameNote,
                                      description: descriptionNote,
                                      date: DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now())
                                          .toString());
                                  refreshNotes(addnote);
                                  http.Response editCrop = await editCropDb(
                                          json.encode(currentCrop.toJson()),
                                          urlNote);
                                  cropsRep.refreshAll();
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
          IconData(
            0xe449,
            fontFamily: 'MaterialIcons',
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}

String calculateAge(final initialAge) {
  List<String> split = initialAge.toString().split('-');
  int year, month, day;
  year = int.parse(split[0]);
  assert(year is int);
  month = int.parse(split[1]);
  assert(month is int);
  day = int.parse(split[2]);
  assert(day is int);
  final atual = DateTime.now();
  final initial = DateTime(day, month, year);
  return atual.difference(initial).inDays.toString();
}
