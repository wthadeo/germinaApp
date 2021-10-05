
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main(){
  runApp(Container(
    child: Center(child: Text(
        'Flutterando 2',
        textDirection: TextDirection.ltr,
        style: TextStyle(color: Colors.white, fontSize: 50.0),
      ),
    )
  ));
}