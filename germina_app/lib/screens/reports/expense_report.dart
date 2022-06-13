import 'dart:io';
import 'package:flutter/material.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/reports/reportIrrigation.dart';
import 'package:germina_app/repositories/nutrients_repository.dart';
import 'package:germina_app/repositories/reports_irrigations_repository.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants.dart';
import 'package:pdf/widgets.dart' as pw;

class ExpenseReport extends StatefulWidget {
  const ExpenseReport({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExpenseReportState();
  static final List<Nutrient> nutrients = NutrientsRepository.listOfNutrients;
  static final List<ReportIrrigation> reportsIrrigations =
      ReportsIrrigationRepository.listOfReportsIrrigations;
}

class _ExpenseReportState extends State<ExpenseReport> {
  final pw.Document pdf = pw.Document();
  static double nutrientExpense = 0;
  static double irrigationsExpense = 0;
  static double totalExpense = 0;

  atualiza() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    atualiza();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Relatório de Gastos Totais",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                const Text(
                  'Gastos com Nutrientes',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      backgroundColor: Colors.yellow),
                ),
                dataTableNutrients(ExpenseReport.nutrients, nutrientExpense),
                const Text(
                  'Gastos com Irrigações',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      backgroundColor: Colors.yellow),
                ),
                dataTable(ExpenseReport.reportsIrrigations, irrigationsExpense),
                const Text(
                  'Total de Gastos',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      backgroundColor: Colors.yellow),
                ),
                tableResult(ExpenseReport.reportsIrrigations,
                    ExpenseReport.nutrients, totalExpense)
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () async {
          /*
          pdf.addPage(pw.MultiPage(
              build: (context) => [
                    pw.Table.fromTextArray(
                        context: context,
                        data: <List<String>>[
                          <String>['Cultivo', 'Data de Criação'],
                          ...ReportsCrops.crops
                              .map((crop) => [crop.name, crop.dateOfCreation])
                        ])
                  ]));

          List<int> bytes = await pdf.save();

          saveAndLaunchFile(bytes, 'reportCrops');
        */
        },
        child: const Icon(
          Icons.adobe_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

Future<void> saveAndLaunchFile(List<int> bytes, String filename) async {
  final path = (await getExternalStorageDirectory())?.path;
  final file = File('$path/$filename');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$filename');
}

DataTable dataTableNutrients(List<Nutrient> nutrients, double nutrientExpense) {
  List<DataRow> rows = [];

  for (var nutrient in nutrients) {
    for (var noteNutrient in nutrient.buysNutrient) {
      rows.add(DataRow(
        cells: [
          DataCell(Text(nutrient.name)),
          DataCell(Text(noteNutrient.quantAdd.toString())),
          DataCell(Text('R\$ ' + noteNutrient.price.toStringAsFixed(2))),
          DataCell(Text(noteNutrient.date)),
        ],
      ));
      nutrientExpense = nutrientExpense + noteNutrient.price;
    }
  }

  // ignore: avoid_function_literals_in_foreach_calls
  /*nutrients.forEach((crop) {
    rows.add(DataRow(cells: [
      DataCell(
        Text(crop.name),
      ),
    ]));
  });*/

  return DataTable(
    columns: const [
      DataColumn(
        label: Text(
          'Nutriente',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Quantidade adicionada (mg)',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Valor Gasto R\$',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Data da adição',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    ],
    rows: rows,
  );
}

DataTable dataTable(
    List<ReportIrrigation> irrigationsReports, double irrigationsExpense) {
  List<DataRow> rows = [];

  // ignore: avoid_function_literals_in_foreach_calls
  irrigationsReports.forEach((report) {
    rows.add(DataRow(cells: [
      DataCell(
        Text(report.description),
      ),
      DataCell(
        Text(report.date),
      ),
      DataCell(
        Text(report.cropUsed),
      ),
      DataCell(
        Text('R\$ ' + report.waterSpended.toStringAsFixed(2)),
      ),
      DataCell(
        Text('R\$ ' + report.energySpended.toStringAsFixed(2)),
      ),
      DataCell(
        Text('R\$ ' + report.nutrientSpended.toStringAsFixed(2)),
      ),
      DataCell(
        Text('R\$ ' + report.totalSpended.toStringAsFixed(2)),
      ),
    ]));
    irrigationsExpense = irrigationsExpense + report.totalSpended;
  });

  return DataTable(
    columns: const [
      DataColumn(
        label: Text(
          'Irrigação',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Data de Criação',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Cultivo',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Gastos com água',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Gastos com Energia',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Gastos com Nutrientes',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Gastos totais',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    ],
    rows: rows,
  );
}

DataTable tableResult(List<ReportIrrigation> irrigationsReports,
    List<Nutrient> nutrients, double totalExpense) {
  irrigationsReports.forEach((report) {
    totalExpense = totalExpense + report.totalSpended;
  });

  for (var nutrient in nutrients) {
    for (var noteNutrient in nutrient.buysNutrient) {
      totalExpense = totalExpense + noteNutrient.price;
    }
  }

  return DataTable(
    columns: const [
      DataColumn(
        label: Text(
          'Total de Gastos',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    ],
    rows: [
      DataRow(cells: [
        DataCell(Text('R\$ ' + totalExpense.toStringAsFixed(2))),
      ])
    ],
  );
}
