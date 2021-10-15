import 'package:flutter/material.dart';

import '../../constants.dart';

class IrrigationsPage extends StatefulWidget {
  const IrrigationsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IrrigationsPageState();
}

class _IrrigationsPageState extends State<IrrigationsPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      title:const Text(
        "Irrigações",
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      backgroundColor: primaryColor,
    ));
  }
}
