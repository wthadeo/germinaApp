import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CropAdd extends StatefulWidget {
  const CropAdd({Key? key}) : super(key: key);

  @override
  _CropAddState createState() => _CropAddState();
}

class _CropAddState extends State<CropAdd> {
  late CropsRepository cropsRep;
  String name = '';
  final atualDate = DateTime.now();
  String age = '';
  int qntOfPlants = 0;
  Crop cropAdded =
      Crop(name: '', age: '', qntOfPlants: 0, isActive: true, notesCrop: []);
  List<Crop> crops = CropsRepository.listOfCrops;

  var url = Uri.parse('http://192.168.1.12:3000/crops');

  @override
  Widget build(BuildContext context) {
    cropsRep = Provider.of<CropsRepository>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Novo Cultivo",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    name = text;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Nome',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    age = text;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      labelText: 'Data Inicial Cultivo',
                      hintText: 'dd-mm-aaaa')),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    qntOfPlants = int.parse(text);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Quantidade de Plantas',
                  )),
            ),
            const SizedBox(
              height: 160.0,
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
                  cropAdded = Crop(
                      name: name,
                      age: age,
                      qntOfPlants: qntOfPlants,
                      isActive: true,
                      notesCrop: []);
                  crops.add(cropAdded);
                  http.Response saveToDB = await saveToDb(cropAdded, url);
                  cropsRep.saveAll(crops);
                  Navigator.pop(context);
                },
                child: const Text('Adicionar Cultivo'))
          ],
        ),
      ),
    );
  }
}

Future<http.Response> saveToDb(Crop crop, var url) async {
  final http.Response response = await http.post(url, body: {
    'name': crop.name,
    'age': crop.age.toString(),
    'qntOfPlants': crop.qntOfPlants.toString(),
    'isActive': crop.isActive.toString(),
    'notesCrop': ''
  });
  return response;
}

//'notesCrop': jsonEncode({"name": "was", "description": "desc", "date": "22-10-2021"})