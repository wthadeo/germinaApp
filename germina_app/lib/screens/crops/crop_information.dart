import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/note.dart';
import 'package:intl/intl.dart';

class CropInformation extends StatefulWidget {
  CropInformation({Key? key}) : super(key: key);

  @override
  State<CropInformation> createState() => _CropInformationState();
}

class _CropInformationState extends State<CropInformation> {
  Crop currentCrop = Communicator.currentCrop;

  List<Note> notesCrop = Communicator.currentCrop.notesCrop;

  String nameNote = '';

  String descriptionNote = '';

  void refreshNotes(Note note) {
    setState(() {
      Communicator.currentCrop.notesCrop.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            'Info',
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
                                  decoration:
                                      const InputDecoration(hintText: 'Descrição'),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: const Text("Adicionar"),
                                onPressed: () {
                                  addnote = Note(
                                      name: nameNote,description: descriptionNote, date: DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now())
                                          .toString());
                                  refreshNotes(addnote);
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
