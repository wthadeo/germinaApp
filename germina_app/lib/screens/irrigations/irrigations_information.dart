import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/irrigation.dart';

class IrrigationInformation extends StatefulWidget {
  const IrrigationInformation({Key? key}) : super(key: key);

  @override
  _IrrigationInformationState createState() => _IrrigationInformationState();
}

class _IrrigationInformationState extends State<IrrigationInformation> {
  Irrigation currentIrrigation = Communicator.currentIrrigator;
  //List<Notification> listOfNotifications = currentIrrigation.listOfNotifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            currentIrrigation.name,
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                alignment: Alignment.center,
                height: 330.0,
                width: 400.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: 400.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const ListTile(
                            leading: Text(
                              'Informações do Cultivo',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                              'Ativo',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Nome: ' + currentIrrigation.name,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Tempo : ' +
                            currentIrrigation.timeToUse.toString() +
                            ' minutos',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Cultivo: ' + currentIrrigation.crop.name,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Vazão: ' + currentIrrigation.flowRate.toString() + ' L/h',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Energia: ' + currentIrrigation.energy.toString() + ' kWh',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Dispositivos: \n' + listOf(currentIrrigation.sensor),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        'Nutrientes: ' + listOf(currentIrrigation.nutrient),
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  height: 260.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Notificações',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              right: 10.0, left: 10.0, bottom: 10.0),
                          child: Container(
                            alignment: Alignment.center,
                            height: 180.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[500],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int note) {
                                return Column(
                                  children: [
                                    Text(
                                      'Quantidade: ' /* +
                                          addNutrientList[note]
                                              .quantAdd
                                              .toString()*/
                                      ,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Valor: ' /*+
                                          addNutrientList[note]
                                              .price
                                              .toStringAsFixed(2)*/
                                      ,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Data de Cadastro: ' /*+
                                          DateFormat('dd-MM-yyyy')
                                              .format(
                                                  addNutrientList[note].date)
                                              .toString()*/
                                      ,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                );
                              },
                              padding: const EdgeInsets.all(16),
                              separatorBuilder: (_, __) => const Divider(),
                              itemCount: 0,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}

String listOf(List state){

  String result = '';

  for(int i = 0; i < state.length; i++){

    if(i < state.length-1){
      result = result + state[i].name + ' | ';
    } else {
      result = result + state[i].name;
    }

  }
  return result;
}