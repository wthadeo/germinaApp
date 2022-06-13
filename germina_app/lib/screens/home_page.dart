import 'package:flutter/material.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:germina_app/repositories/irrigations_repository.dart';
import 'package:germina_app/repositories/nutrients_repository.dart';
import 'package:germina_app/repositories/reports_crops_repository.dart';
import 'package:germina_app/repositories/reports_irrigations_repository.dart';
import 'package:germina_app/repositories/reports_nutrients_repository.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*var urlIrrigations = homeIrrigUrl;
  var urlCrops = homeCropsUrl;
  var urlNutrients = homeNutrientsUrl;
  var urlReportsCrops = reportsCropsUrl;*/

  // ignore: prefer_typing_uninitialized_variables
  late final dataFromApi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "GerminaApp",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder(
        future: dataFromApi = Future.wait([
          IrrigationsRepository.getIrrigationsFromApi(homeIrrigUrl),
          CropsRepository.getCropsFromApi(homeCropsUrl),
          NutrientsRepository.getNutrientsFromApi(homeNutrientsUrl),
          ReportsCropsRepository.getReportCropsFromApi(reportsCropsUrl),
          ReportsIrrigationRepository.getReportIrrigationsFromApi(
              reportsIrrigationsUrl),
          ReportsNutrientsRepository.getReportNutrientsFromApi(
              reportsNutrientsUrl)
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            IrrigationsRepository.listOfIrrigations = snapshot.data?[0]!;
            CropsRepository.listOfCrops = snapshot.data?[1]!;
            NutrientsRepository.listOfNutrients = snapshot.data?[2]!;
            ReportsCropsRepository.listOfReportsCrops = snapshot.data?[3]!;
            ReportsIrrigationRepository.listOfReportsIrrigations =
                snapshot.data?[4]!;
            ReportsNutrientsRepository.listOfReportsNutrients =
                snapshot.data?[5]!;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buttonMenu('Dispositivos', context, '/devices'),
                  buttonMenu('Cultivos', context, '/crops'),
                  buttonMenu('Nutrientes', context, '/nutrients'),
                  buttonMenu('Irrigações', context, '/irrigations'),
                  buttonMenu('Relatórios', context, '/reports'),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
