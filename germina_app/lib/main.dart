import 'package:flutter/material.dart';
import 'package:germina_app/repositories/sensors_repository.dart';
import 'package:germina_app/screens/crops/crops.dart';
import 'package:germina_app/screens/home_page.dart';
import 'package:germina_app/screens/intro_page.dart';
import 'package:germina_app/screens/irrigations/irrigations.dart';
import 'package:germina_app/screens/nutrients/nutrients.dart';
import 'package:germina_app/screens/reports/reports.dart';
import 'package:germina_app/screens/sensors/sensors.dart';
import 'package:provider/provider.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(66, 174, 181, .1),
  100: const Color.fromRGBO(66, 174, 181, .2),
  200: const Color.fromRGBO(66, 174, 181, .3),
  300: const Color.fromRGBO(66, 174, 181, .4),
  400: const Color.fromRGBO(66, 174, 181, .5),
  500: const Color.fromRGBO(66, 174, 181, .6),
  600: const Color.fromRGBO(66, 174, 181, .7),
  700: const Color.fromRGBO(66, 174, 181, .8),
  800: const Color.fromRGBO(66, 174, 181, .9),
  900: const Color.fromRGBO(66, 174, 181, 1),
};

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => SensorsRepository(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
