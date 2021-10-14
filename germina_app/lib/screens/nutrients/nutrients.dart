import 'package:flutter/material.dart';

import '../../constants.dart';

class NutrientsPage extends StatefulWidget {
  const NutrientsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NutrientsPageState();
}

class _NutrientsPageState extends State<NutrientsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      title: const Text(
        "Nutrientes",
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      backgroundColor: primaryColor,
    ));
  }
}
