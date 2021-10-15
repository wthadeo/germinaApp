import 'package:flutter/material.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/repositories/nutrients_repository.dart';
import 'package:provider/provider.dart';

class NutrientAdd extends StatefulWidget {
  const NutrientAdd({Key? key}) : super(key: key);

  @override
  _NutriendAddState createState() => _NutriendAddState();
}

class _NutriendAddState extends State<NutrientAdd> {
  late NutrientsRepository nutrientsRep;
  String name = '';
  String interval = '';
  int totalAmount = 0;
  double price = 0.0;
  Nutrient nutrientAdded = Nutrient('', '', 0, 0);
  List<Nutrient> nutrients = NutrientsRepository.listOfNutrients;

  @override
  Widget build(BuildContext context) {

    nutrientsRep = Provider.of<NutrientsRepository>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Novo Nutriente",
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
                    interval = text;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Intervalo',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    totalAmount = int.parse(text);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Quantidade',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    if(text.contains(',')){
                      List<String> priceCorrection = text.split(',');
                      String priceCorrected = priceCorrection[0] + '.' + priceCorrection[1];
                      price = double.parse(priceCorrected);
                    } else {
                      price = double.parse(text);
                    }
                    
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Preço',
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
                  
                    nutrientAdded = Nutrient(name, interval, totalAmount, price);
                    nutrients.add(nutrientAdded);
                    nutrientsRep.saveAll(nutrients);
                    Navigator.pop(context);
                },
                child: const Text('Adicionar Nutriente'))
          ],
        ),
      ),
    );
  }
}