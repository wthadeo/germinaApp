import 'dart:io';
import 'package:flutter/material.dart';
import 'package:germina_app/models/reports/reportIrrigation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../repositories/reports_irrigations_repository.dart';

class ReportsIrrigations extends StatefulWidget {
  const ReportsIrrigations({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportsIrrigationsState();
  static final List<ReportIrrigation> irrigations =
      ReportsIrrigationRepository.listOfReportsIrrigations;
}

class _ReportsIrrigationsState extends State<ReportsIrrigations> {
  final pw.Document pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Relatório de Todas Irrigações",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: dataTable(ReportsIrrigations.irrigations)),
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

DataTable dataTable(List<ReportIrrigation> irrigationsReports) {
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
