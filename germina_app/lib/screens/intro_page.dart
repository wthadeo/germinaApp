import 'package:flutter/material.dart';
import 'package:germina_app/screens/home_page.dart';

import '../constants.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color.fromRGBO(200, 241, 241, 8), Colors.white])),
      child: Column(
        children: [
          const SizedBox(
            height: 100.0,
          ),
          SizedBox(
              height: 300.0,
              width: 300.0,
              child: Image.asset('lib/assets/images/logo.png')),
          const SizedBox(
            child: Padding(
              padding: EdgeInsets.only(left: 35.0, right: 30.0),
              child: Text(
                'Gerenciamento e monitoramento na Agricultura',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(66, 174, 181, 1),
                  decoration: TextDecoration.none,
                  fontFamily: 'Roboto', 
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100.0,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  onPrimary: const Color.fromRGBO(255, 255, 255, 1),
                  primary: const Color.fromRGBO(66, 174, 181, 1),
                  minimumSize: const Size(300, 60),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text('Iniciar', style: TextStyle(fontSize: 20.0),)),
        ],
      ),
    );
  }
}
