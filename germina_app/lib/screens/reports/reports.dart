import 'package:flutter/material.dart';

class ReportsPage extends StatefulWidget{
  
  
  @override
  State<StatefulWidget> createState() => _ReportsPageState();
  }

class _ReportsPageState extends State<ReportsPage>{
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
            "Relatórios", 
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          backgroundColor: Color.fromRGBO(66, 174, 181, 95),
        ),
      )
    );
  }
}