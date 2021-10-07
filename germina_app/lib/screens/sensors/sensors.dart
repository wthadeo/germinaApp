import 'package:flutter/material.dart';

class SensorsPage extends StatefulWidget{
  
  
  @override
  State<StatefulWidget> createState() => _SensorsPageState();
  }

class _SensorsPageState extends State<SensorsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: PreferredSize
      (
        preferredSize: Size.fromHeight(60),
        child: AppBar
        (
          centerTitle: true,
          title: Text
          (
            "Sensores", 
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          backgroundColor: Color.fromRGBO(66, 174, 181, 95),
        ),
      )
    );
  }
}