import 'package:flutter/material.dart';

class NutrientsPage extends StatefulWidget{
  
  
  @override
  State<StatefulWidget> createState() => _NutrientsPageState();
  }

class _NutrientsPageState extends State<NutrientsPage>{
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
            "Nutrientes", 
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          backgroundColor: Color.fromRGBO(66, 174, 181, 95),
        ),
      )
    );
  }
}