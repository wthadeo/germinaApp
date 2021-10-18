import 'package:flutter/material.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/crop.dart';
import 'package:germina_app/models/hour.dart';
import 'package:germina_app/models/nutrient.dart';
import 'package:germina_app/models/sensors/sensor.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:germina_app/repositories/irrigations_repository.dart';
import 'package:germina_app/repositories/nutrients_repository.dart';
import 'package:germina_app/repositories/sensors_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IrrigationsAdd extends StatefulWidget {
  const IrrigationsAdd({Key? key}) : super(key: key);

  @override
  _IrrigationsAddState createState() => _IrrigationsAddState();
}

class _IrrigationsAddState extends State<IrrigationsAdd> {
  late IrrigationsRepository irrigationsRep;
  List<Crop> currentCrops = CropsRepository.listOfCrops;
  List<Sensor> currentSensors = SensorsRepository.listOfSensors;
  List<Nutrient> currentNutrients = NutrientsRepository.listOfNutrients;
  late Crop cropChoose = currentCrops[0];
  late Sensor sensorChosed = currentSensors[0];
  late Nutrient nutrientChosed = currentNutrients[0];
  List<Sensor> sensorsChoose = [];
  List<Nutrient> nutrientsChoose = [];
  
  String name = '';
  TimeOfDay initialHour = TimeOfDay(
      hour: int.parse(DateFormat('hh').format(DateTime.now())),
      minute: int.parse(DateFormat('mm').format(DateTime.now())));
  int minutesActive = 0;
  Hour hourToStop = Hour(0, 0);
  int flowRate = 0;
  double energyPrice = 0;
  

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: initialHour,
    );
    if (newTime != null) {
      setState(() {
        initialHour = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    irrigationsRep = Provider.of<IrrigationsRepository>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Nova Irrigação",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    name = text;
                    print(initialHour.toString());
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Nome',
                    hintText: 'Nome da Irrigação',
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 6.0, right: 20.0, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: ElevatedButton(
                        onPressed: _selectTime,
                        child: const Text('Hora Início'),
                        style: ElevatedButton.styleFrom(
                            onPrimary: const Color.fromRGBO(255, 255, 255, 1),
                            minimumSize: const Size(140, 50),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        minutesActive = int.parse(text);
                        print(minutesActive.toString());
                      },
                      decoration: const InputDecoration(
                          labelText: 'Duração(min)',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        flowRate = int.parse(text);
                        print(flowRate.toString());
                      },
                      decoration: const InputDecoration(
                          labelText: 'Vazão(L/H)',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        if (text.contains(',')) {
                          List<String> priceCorrection = text.split(',');
                          String priceCorrected =
                              priceCorrection[0] + '.' + priceCorrection[1];
                          energyPrice = double.parse(priceCorrected);
                        } else {
                          energyPrice = double.parse(text);
                        }
                        print(energyPrice.toString());
                      },
                      decoration: const InputDecoration(
                          labelText: 'Valor Energia (kWh)',
                          hintText: 'R\$',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Cultivo',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.5,
                    color: primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 25, right: 25),
              child: DropdownButton<Crop>(
                value: cropChoose,
                isExpanded: true,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: primaryColor),
                underline: Container(
                  height: 2,
                  color: primaryColor,
                ),
                items: currentCrops.map((item) {
                  return DropdownMenuItem<Crop>(
                    child: Text(item.name),
                    value: item,
                  );
                }).toList(),
                onChanged: (Crop? newValue) {
                  setState(() {
                    cropChoose = newValue!;
                    print(cropChoose.name);
                  });
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Dispositivo',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.5,
                    color: primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 25, right: 25),
              child: DropdownButton<Sensor>(
                value: sensorChosed,
                isExpanded: true,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: primaryColor),
                underline: Container(
                  height: 2,
                  color: primaryColor,
                ),
                items: currentSensors.map((item) {
                  return DropdownMenuItem<Sensor>(
                    child: Text(item.name),
                    value: item,
                  );
                }).toList(),
                onChanged: (Sensor? newValue) {
                  setState(() {
                    sensorChosed = newValue!;
                    print(sensorChosed.name);
                  });
                  if(!sensorsChoose.contains(sensorChosed)){
                    sensorsChoose.add(sensorChosed);
                    print(sensorsChoose);
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Nutrientes',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.5,
                    color: primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 25, right: 25),
              child: DropdownButton<Crop>(
                value: cropChoose,
                isExpanded: true,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: primaryColor),
                underline: Container(
                  height: 2,
                  color: primaryColor,
                ),
                items: currentCrops.map((item) {
                  return DropdownMenuItem<Crop>(
                    child: Text(item.name),
                    value: item,
                  );
                }).toList(),
                onChanged: (Crop? newValue) {
                  setState(() {
                    cropChoose = newValue!;
                    print(cropChoose.name);
                  });
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: primaryColor,
                    minimumSize: const Size(300, 60),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onPressed: () {},
                child: const Text('Agendar Irrigação'))
          ],
        ),
      ),
    );
  }
}




/*
  SizedBox(height: 100,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: primaryColor,
                    minimumSize: const Size(300, 60),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onPressed: () {
                  
                  
                },
                child: const Text('Agendar Irrigação'))
*/