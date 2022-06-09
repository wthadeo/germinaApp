// ignore_for_file: file_names

class ReportIrrigation {
  String description;
  String date;
  String cropUsed;
  double waterSpended;
  double energySpended;
  double nutrientSpended;
  double totalSpended;

  ReportIrrigation(
      {required this.description,
      required this.date,
      required this.cropUsed,
      required this.waterSpended,
      required this.energySpended,
      required this.nutrientSpended,
      required this.totalSpended});

  factory ReportIrrigation.fromJson(Map<String, dynamic> json) {
    return ReportIrrigation(
      description: json['description'],
      date: json['date'],
      cropUsed: json['cropUsed'],
      waterSpended: json['waterSpended'].toDouble(),
      energySpended: json['energySpended'].toDouble(),
      nutrientSpended: json['nutrientSpended'].toDouble(),
      totalSpended: json['totalSpended'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['date'] = date;
    data['cropUsed'] = cropUsed;
    data['waterSpended'] = waterSpended;
    data['energySpended'] = energySpended;
    data['nutrientSpended'] = nutrientSpended;
    data['totalSpended'] = totalSpended;
    return data;
  }

  double spendsWithWater(int durationTime, int flowRate, double waterCost) {
    double value;

    value = (((durationTime / 60) * flowRate) / 1000) * waterCost;

    return value;
  }

  double spendsWithEnergy(int durationTime, double energyCost) {
    double value = (durationTime / 60) * energyCost;
    return value;
  }

  double spendsWithNutrients(Map<String, double> nutrientsCost) {
    return 0;
  }
}
