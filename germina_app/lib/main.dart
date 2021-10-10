import 'package:flutter/material.dart';
import 'package:germina_app/screens/crops/crops.dart';
import 'package:germina_app/screens/home_page.dart';
import 'package:germina_app/screens/intro_page.dart';
import 'package:germina_app/screens/irrigations/irrigations.dart';
import 'package:germina_app/screens/nutrients/nutrients.dart';
import 'package:germina_app/screens/reports/reports.dart';
import 'package:germina_app/screens/sensors/sensors.dart';



Map<int, Color> color = {
  50: Color.fromRGBO(66, 174, 181, .1),
  100: Color.fromRGBO(66, 174, 181, .2),
  200: Color.fromRGBO(66, 174, 181, .3),
  300: Color.fromRGBO(66, 174, 181, .4),
  400: Color.fromRGBO(66, 174, 181, .5),
  500: Color.fromRGBO(66, 174, 181, .6),
  600: Color.fromRGBO(66, 174, 181, .7),
  700: Color.fromRGBO(66, 174, 181, .8),
  800: Color.fromRGBO(66, 174, 181, .9),
  900: Color.fromRGBO(66, 174, 181, 1),
};

void main() => runApp(MyApp());


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
      routes: 
      {
        '/': (context) => const IntroPage(),
        '/homePage': (context) => const HomePage(),
        //ROTAS DAS PAGINAS DE SENSORES
        '/sensors': (context) => SensorsPage(),
        //ROTAS DAS PAGINAS DE IRRIGAÇÕES
        '/irrigations': (context) => IrrigationsPage(),
        //ROTAS DAS PAGINAS DE CULTIVOS
        '/crops': (context) => CropsPage(),
        //ROTAS DAS PAGINAS DE NUTRIENTES
        '/nutrients': (context) => NutrientsPage(),
        //ROTAS DAS PAGINAS DE RELATÓRIOS
        '/reports': (context) => ReportsPage(),
      },
    );
  }
}
