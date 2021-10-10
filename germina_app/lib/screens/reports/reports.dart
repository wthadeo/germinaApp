import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      title: const Text(
        "Relatórios",
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      backgroundColor: const Color.fromRGBO(66, 174, 181, 95),
    ));
  }
}
