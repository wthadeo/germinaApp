import 'dart:convert';
import 'package:germina_app/models/reports/reportCrop.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../constants.dart';
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
  String age = '';
  int qntOfPlants = 0;
  Crop cropAdded = Crop(
      name: '',
      dateOfCreation: '',
      age: '',
      qntOfPlants: 0,
      costOfCrop: 0,
      isActive: true,
      notesCrop: []);
  ReportCrop initialReport = ReportCrop(description: '', date: '', value: 0);
  List<Crop> crops = CropsRepository.listOfCrops;

  var url = homeCropsUrl;
  var urlReport = Uri.parse('http://192.168.0.113:3000/reportCrop');

  var maskFormatter = MaskTextInputFormatter(
      mask: '##-##-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final _controller = TextEditingController();

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
                  inputFormatters: [maskFormatter],
                  onChanged: (text) {
                    age = maskFormatter.getMaskedText();
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
                  controller: _controller,
                  onChanged: (text) {
                    qntOfPlants = int.parse(_controller.text);
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
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
                  initialReport =
                      ReportCrop(description: name, date: age, value: 0);
                  cropAdded = Crop(
                      name: name,
                      dateOfCreation: age,
                      age: calculateAge(age),
                      qntOfPlants: qntOfPlants,
                      costOfCrop: 0,
                      isActive: true,
                      notesCrop: []);
                  crops.add(cropAdded);
                  // ignore: unused_local_variable
                  http.Response saveToDB =
                      await saveToDb(json.encode(cropAdded.toJson()), url);
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

Future<http.Response> saveToDb(String crop, var url) async {
  final http.Response response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: crop);
  return response;
}

String calculateAge(final initialAge) {
  List<String> split = initialAge.toString().split('-');
  int year, month, day;
  year = int.parse(split[0]);
  // ignore: unnecessary_type_check
  assert(year is int);
  month = int.parse(split[1]);
  // ignore: unnecessary_type_check
  assert(month is int);
  day = int.parse(split[2]);
  // ignore: unnecessary_type_check
  assert(day is int);
  final atual = DateTime.now();
  final initial = DateTime(day, month, year);
  return atual.difference(initial).inDays.toString();
}
//'notesCrop': jsonEncode({"name": "was", "description": "desc", "date": "22-10-2021"})