class Nutrient {
  String name;
  double priceMg;
  int totalAmount;

  Nutrient(
      {required this.name, required this.priceMg, required this.totalAmount});

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
        name: json['name'] as String,
        priceMg:json['price'].toDouble(),
        totalAmount: json['totalAmount'] as int);
  }
}
