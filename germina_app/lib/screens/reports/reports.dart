import 'package:flutter/material.dart';

import '../../constants.dart';

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
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buttonMenu('Todos Cultivos', context, '/reportsCrops'),
            buttonMenu('Gastos com Cultivos', context, '/cropsExpenses'),
            buttonMenu('Gastos com Nutrientes', context, '/reportsNutrients'),
            buttonMenu('Compra de Nutrientes', context, '/buyNutrients'),
            buttonMenu('Todas Irrigações', context, '/reportsIrrigations'),
            buttonMenu('Relatório Geral de Gastos', context, '/expenseReport'),
          ],
        ),
      ),
    );
  }
}

Widget buttonMenu(String title, dynamic context, String nextPage) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          child: ElevatedButton(
              style: raisedButtonStyle,
              onPressed: () {
                Navigator.pushNamed(context, nextPage);
              },
              child: Text(title)),
        ),
      ),
    ],
  );
}
