import 'package:flutter/material.dart';

import '../../constants.dart';

class ReportsCrops extends StatefulWidget {
  const ReportsCrops({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportsCropsState();
}

class _ReportsCropsState extends State<ReportsCrops> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      title: const Text(
        "Relatório de Todos Cultivos",
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      backgroundColor: primaryColor,
    ));
  }
}
