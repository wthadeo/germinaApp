import 'package:flutter/material.dart';

class SensorsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      title: const Text(
        "Sensores",
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      backgroundColor: const Color.fromRGBO(66, 174, 181, 95),
    ),
    body: Container(
      child: Column(
        children: [

        ],
      ),
    ),
    );
  }
}

// 3 SENSORES DE UMIDADE DO SOLO ()
// 1 SENSOR DE TEMPERATURA AMBIENTE/UMIDADE DO AR (DTH11)