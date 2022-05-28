import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/repositories/nutrients_repository.dart';
import 'package:germina_app/screens/nutrients/nutrients_add.dart';
import 'package:germina_app/screens/nutrients/nutrients_information.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class NutrientsPage extends StatefulWidget {
  const NutrientsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NutrientsPageState();
}

class _NutrientsPageState extends State<NutrientsPage> {
  late NutrientsRepository nutrientsRep;
  static List<Nutrient> nutrients = NutrientsRepository.listOfNutrients;

  @override
  Widget build(BuildContext context) {
    nutrientsRep = Provider.of<NutrientsRepository>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Nutrientes",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: GridView.builder(
          itemCount: nutrients.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 0.1,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) => NutrientView(index, context)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NutrientAdd()));
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
Widget NutrientView(int index, dynamic context) {
  String name = _NutrientsPageState.nutrients[index].name;

  return GestureDetector(
    onTap: () {
      Communicator.currentNutrient = _NutrientsPageState.nutrients[index];
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const NutrientInformation()));
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
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
        ),
      ),
    ),
  );
}
