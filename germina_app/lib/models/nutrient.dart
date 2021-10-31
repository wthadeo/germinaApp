class Nutrient {
  String name;
  double priceMg;
  int totalAmount;

  Nutrient(
      {required this.name, required this.priceMg, required this.totalAmount});

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
        name: json['name'],
        priceMg: json['price'],
        totalAmount: json['totalAmount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['price'] = priceMg;
    data['totalAmount'] = totalAmount;
    return data;
  }

}