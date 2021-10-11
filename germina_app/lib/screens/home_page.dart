import 'package:flutter/material.dart';

import '../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  
  //final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "GerminaApp",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: const Color.fromRGBO(66, 174, 181, 95),
      ),
      body: Column(
        children: <Widget>[
          buttonMenu('Sensores', context, '/sensors'),
          buttonMenu('Irrigações', context, '/irrigations'),
          buttonMenu('Cultivos', context, '/crops'),
          buttonMenu('Nutrientes', context, '/nutrients'),
          buttonMenu('Relatórios', context, '/reports'),
        ],
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
