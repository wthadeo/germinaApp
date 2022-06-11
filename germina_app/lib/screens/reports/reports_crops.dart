import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants.dart';
import '../../models/crop.dart';
import '../../repositories/crops_repository.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportsCrops extends StatefulWidget {
  const ReportsCrops({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportsCropsState();
  static final List<Crop> crops = CropsRepository.listOfCrops;
}

class _ReportsCropsState extends State<ReportsCrops> {
  final pw.Document pdf = pw.Document();

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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: dataTable(ReportsCrops.crops)),
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () async {
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
        },
        child: const Icon(
          Icons.adobe_outlined,
          color: Colors.white,
        ),
      ),*/
    );
  }
}

Future<void> saveAndLaunchFile(List<int> bytes, String filename) async {
  final path = (await getExternalStorageDirectory())?.path;
  final file = File('$path/$filename');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$filename');
}

DataTable dataTable(List<Crop> crops) {
  List<DataRow> rows = [];

  Text isActive(Crop crop) {
    if (crop.isActive) {
      return const Text('Ativo');
    } else {
      return const Text('Concluido');
    }
  }

  // ignore: avoid_function_literals_in_foreach_calls
  crops.forEach((crop) {
    rows.add(DataRow(cells: [
      DataCell(
        Text(crop.name),
      ),
      DataCell(
        Text(crop.dateOfCreation),
      ),
      DataCell(
        Text(crop.age),
      ),
      DataCell(
        Text(crop.qntOfPlants.toString()),
      ),
      DataCell(
        Text(crop.costOfCrop.toString()),
      ),
      DataCell(
        isActive(crop),
      ),
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
          'Data de Criação',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Idade (dias)',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Quantidade de Plantas',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Custo do Cultivo',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Estado',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    ],
    rows: rows,
  );
}
