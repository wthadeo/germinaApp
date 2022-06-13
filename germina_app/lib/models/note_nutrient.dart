class NoteNutrient {
  int quantAdd;
  double price;
  String date;

  NoteNutrient(
      {required this.quantAdd, required this.price, required this.date});

  factory NoteNutrient.fromJson(Map<String, dynamic> json) {
    return NoteNutrient(
        quantAdd: json['quantAdd'],
        price: json['price'].toDouble(),
        date: json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantAdd'] = quantAdd;
    data['price'] = price;
    data['date'] = date;
    return data;
  }
}
