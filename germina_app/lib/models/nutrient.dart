import 'package:germina_app/models/note_nutrient.dart';

class Nutrient {
  String name;
  double priceMg;
  int totalAmount;
  List<NoteNutrient> buysNutrient;

  Nutrient(
      {required this.name,
      required this.priceMg,
      required this.totalAmount,
      required this.buysNutrient});

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    var listBuys = json['buysNutrient'] as List;

    List<NoteNutrient> _buysNutrients =
        listBuys.map((v) => NoteNutrient.fromJson(v)).toList();

    return Nutrient(
        name: json['name'],
        priceMg: json['price'].toDouble(),
        totalAmount: json['totalAmount'],
        buysNutrient: _buysNutrients);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = priceMg;
    data['totalAmount'] = totalAmount;
    data['buysNutrient'] = buysNutrient.map((v) => v.toJson()).toList();
    return data;
  }
}
