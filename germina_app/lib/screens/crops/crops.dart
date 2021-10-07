import 'package:flutter/material.dart';

class CropsPage extends StatefulWidget{
  
  
  @override
  State<StatefulWidget> createState() => _CropsPageState();
  }

class _CropsPageState extends State<CropsPage>{
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
            "Cultivos", 
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          backgroundColor: Color.fromRGBO(66, 174, 181, 95),
        ),
      )
    );
  }
}