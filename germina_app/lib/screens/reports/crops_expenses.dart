import 'dart:io';
import 'package:flutter/material.dart';
import 'package:germina_app/models/reports/reportCrop.dart';
import 'package:germina_app/repositories/reports_crops_repository.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants.dart';
import 'package:pdf/widgets.dart' as pw;

class CropsExpenses extends StatefulWidget {
  const CropsExpenses({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CropsExpensesState();
  static final List<ReportCrop> reportCrops =
      ReportsCropsRepository.listOfReportsCrops;
}

class _CropsExpensesState extends State<CropsExpenses> {
  final pw.Document pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Gastos com Cultivos",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: dataTable(CropsExpenses.reportCrops)),
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

DataTable dataTable(List<ReportCrop> reportCrops) {
  List<DataRow> rows = [];

  // ignore: avoid_function_literals_in_foreach_calls
  reportCrops.forEach((report) {
    rows.add(DataRow(cells: [
      DataCell(
        Text(report.description),
      ),
      DataCell(
        Text(report.date),
      ),
      DataCell(
        Text('R\$ ' + report.value.toStringAsFixed(2)),
      )
    ]));
  });

  return DataTable(
    columns: const [
      DataColumn(
        label: Text(
          'Cultivo',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Data da despesa',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Valor',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      )
    ],
    rows: rows,
  );
}
