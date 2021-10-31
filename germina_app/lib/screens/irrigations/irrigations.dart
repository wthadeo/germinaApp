import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/models/irrigation.dart';
import 'package:germina_app/repositories/irrigations_repository.dart';
import 'package:germina_app/screens/irrigations/irrigations_add.dart';
import 'package:germina_app/screens/irrigations/irrigations_information.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class IrrigationsPage extends StatefulWidget {
  const IrrigationsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IrrigationsPageState();
}

class _IrrigationsPageState extends State<IrrigationsPage> {
  late IrrigationsRepository irrigationsRep;
  static List<Irrigation> irrigations = IrrigationsRepository.listOfIrrigations;

  @override
  Widget build(BuildContext context) {
    irrigationsRep = Provider.of<IrrigationsRepository>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Irrigações",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: GridView.builder(
          itemCount: irrigations.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 0.1,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) => IrrigationView(index, context)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const IrrigationsAdd()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget IrrigationView(int index, dynamic context) {
  String name = _IrrigationsPageState.irrigations[index].name;
  bool active = _IrrigationsPageState.irrigations[index].state;

  return GestureDetector(
    onTap: () {
      Communicator.currentIrrigator = _IrrigationsPageState.irrigations[index];
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => IrrigationInformation()));
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
          const SizedBox(
            height: 15.0,
          ),
          Text(
            isActive(active),
            style: TextStyle(
                color: activeColor(active),
                fontSize: 15.0,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

Color activeColor(bool active) {
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
