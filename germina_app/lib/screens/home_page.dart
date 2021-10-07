import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  
  const HomePage({Key? key}) : super(key: key);

  //final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          title: Text(
          "GerminaApp", 
          style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          backgroundColor: Color.fromRGBO(66, 174, 181, 95),
        ),
      ),
      body: Container(

        child: Column(

          children: <Widget>[
            Row(
              children: <Widget>[
                ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: (){
                    print("Fui pra sensores");
                  }, 
                  child: Text('Sensores')
                ),
                ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: (){
                    print("Fui pra Irrigações");
                  }, 
                  child: Text('Irrigações')
                ),
              ],
            ),

            Row(
              children: <Widget>[
                ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: (){
                    print("Fui pra cultivos");
                  }, 
                  child: Text('Cultivos')
                ),
                ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: (){
                    print("Fui pra Nutrientes");
                  }, 
                  child: Text('Nutrientes')
                ),
              ],
            ),

            Row(
              children: <Widget>[
                ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: (){
                    print("Fui pra Relatórios");
                  }, 
                  child: Text('Relatórios')
                ),
              ],
            ),

          ],

        ),

      ),
    );
  }

}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Color.fromRGBO(66, 174, 181, 95),
  primary: Color.fromRGBO(228, 241, 241, 8),
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);