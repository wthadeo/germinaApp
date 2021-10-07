import 'package:flutter/material.dart';

class IrrigationsPage extends StatefulWidget{
  
  
  @override
  State<StatefulWidget> createState() => _IrrigationsPageState();
  }

class _IrrigationsPageState extends State<IrrigationsPage>{
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
            "Irrigações", 
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          backgroundColor: Color.fromRGBO(66, 174, 181, 95),
        ),
      )
    );
  }
}