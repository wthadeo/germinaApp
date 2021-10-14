import 'package:flutter/material.dart';
import 'package:germina_app/constants.dart';

class CropsPage extends StatefulWidget {
  const CropsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CropsPageState();
}

class _CropsPageState extends State<CropsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      title: const Text(
        "Cultivos",
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      backgroundColor: primaryColor,
    ));
  }
}
