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
            buttonMenu('Sensores', null),
            buttonMenu('Irrigações', null),
            buttonMenu('Cultivos', null),
            buttonMenu('Nutrientes', null),
            buttonMenu('Relatórios', null),
  
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

Widget buttonMenu (String title, dynamic context){

  return Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: (){
                        print("Fui pra " + title);
                      }, 
                      child: Text(title)
                    ),
                  ),
                ),
              ],
            );
}