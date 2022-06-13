// ignore_for_file: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/repositories/nutrients_repository.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportsBuyNutrients extends StatefulWidget {
  const ReportsBuyNutrients({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportsBuyNutrientsState();
  static final List<Nutrient> nutrients = NutrientsRepository.listOfNutrients;
}

class _ReportsBuyNutrientsState extends State<ReportsBuyNutrients> {
  final pw.Document pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Compras de Nutrientes",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: dataTable(ReportsBuyNutrients.nutrients)),
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

DataTable dataTable(List<Nutrient> nutrients) {
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
          'Valor Gasto',
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
