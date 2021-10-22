import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:germina_app/screens/crops/crop_add.dart';
import 'package:germina_app/screens/crops/crop_information.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CropsPage extends StatefulWidget {
  const CropsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CropsPageState();
}

class _CropsPageState extends State<CropsPage> {
  late CropsRepository cropRep;
  static List<Crop> crops = CropsRepository.listOfCrops;

  var url = Uri.parse('http://192.168.1.12:3000/crops');

  @override
  Widget build(BuildContext context) {
    cropRep = Provider.of<CropsRepository>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Cultivos",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder(
        future: getCrops(url),
        builder:
              (BuildContext context, AsyncSnapshot<List<Crop>> snapshot) {
            if (snapshot.hasData) {
              crops = snapshot.data!;
              return GridView.builder(
            itemCount: crops.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
                crossAxisSpacing: 0.1,
                mainAxisSpacing: 5),
            itemBuilder: (context, index) => CropView(index, context));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }}),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const CropAdd()));
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget CropView(int index, dynamic context) {
  String name = _CropsPageState.crops[index].name;
  bool active = _CropsPageState.crops[index].isActive;

  return GestureDetector(
    onTap: () {
      Communicator.currentCrop = _CropsPageState.crops[index];
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CropInformation()));
    },
    child: Container(
      height: 300,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(height: 15.0,),
          Text(
            isActive(active),
            style: TextStyle(
              color: activeColor(active),
              fontSize: 15.0,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    ),
  );
}

Future<List<Crop>> getCrops(var url) async {
  http.Response res = await http.get((url));

  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);

    List<Crop> crops = body
        .map(
          (dynamic item) => Crop.fromJson(item),
        )
        .toList();

    return crops;
  } else {
    throw "Unable to retrieve crops.";
  }
}


Color activeColor(bool active){
  if (active) {
    return Colors.green;
  } else {
    return Colors.amber;
  }
}

String isActive(bool isActive) {
  if (isActive) {
    return "Ativo";
  } else {
    return "Completo";
  }
}
