import 'package:flutter/material.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:provider/provider.dart';

class CropAdd extends StatefulWidget {
  const CropAdd({ Key? key }) : super(key: key);

  @override
  _CropAddState createState() => _CropAddState();
}

class _CropAddState extends State<CropAdd> {
  late CropsRepository cropsRep;
  String name = '';
  final atualDate = DateTime.now();
  String age = '';
  int qntOfPlants = 0;
  Crop cropAdded = Crop('', '', 0, true, []);
  List<Crop> crops = CropsRepository.listOfCrops;

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
                    hintText: 'dd-mm-aaaa'
                  )),
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
                onPressed: () {
                    cropAdded = Crop(name, age, qntOfPlants, true, []);
                    crops.add(cropAdded);
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