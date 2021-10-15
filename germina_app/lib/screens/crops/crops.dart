import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:germina_app/screens/crops/crop_add.dart';
import 'package:germina_app/screens/crops/crop_information.dart';
import 'package:provider/provider.dart';

class CropsPage extends StatefulWidget {
  const CropsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CropsPageState();
}

class _CropsPageState extends State<CropsPage> {
  late CropsRepository cropRep;
  static List<Crop> crops = CropsRepository.listOfCrops;

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
      body: GridView.builder(
          itemCount: crops.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 0.1,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) => CropView(index, context)),
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
      Communicator.currentCrop = CropsRepository.listOfCrops[index];
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
