import 'package:flutter/material.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:germina_app/repositories/irrigations_repository.dart';
import 'package:germina_app/repositories/nutrients_repository.dart';
import 'package:germina_app/repositories/sensors_repository.dart';
import 'package:germina_app/screens/crops/crops.dart';
import 'package:germina_app/screens/home_page.dart';
import 'package:germina_app/screens/intro_page.dart';
import 'package:germina_app/screens/irrigations/irrigations.dart';
import 'package:germina_app/screens/nutrients/nutrients.dart';
import 'package:germina_app/screens/reports/reports.dart';
import 'package:germina_app/screens/sensors/sensors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SensorsRepository>(
        create: (context) => SensorsRepository(),
      ),
      ChangeNotifierProvider<CropsRepository>(
        create: (context) => CropsRepository(),
      ),
      ChangeNotifierProvider<IrrigationsRepository>(
        create: (context) => IrrigationsRepository(),
      ),
      ChangeNotifierProvider<NutrientsRepository>(
        create: (context) => NutrientsRepository(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GerminaApp',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF42AEB5, color),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroPage(),
        '/homePage': (context) => const HomePage(),
        //ROTAS DAS PAGINAS DE SENSORES
        '/sensors': (context) => const SensorsPage(),
        //ROTAS DAS PAGINAS DE IRRIGAÇÕES
        '/irrigations': (context) => const IrrigationsPage(),
        //ROTAS DAS PAGINAS DE CULTIVOS
        '/crops': (context) => const CropsPage(),
        //ROTAS DAS PAGINAS DE NUTRIENTES
        '/nutrients': (context) => const NutrientsPage(),
        //ROTAS DAS PAGINAS DE RELATÓRIOS
        '/reports': (context) => const ReportsPage(),
      },
    );
  }
}
