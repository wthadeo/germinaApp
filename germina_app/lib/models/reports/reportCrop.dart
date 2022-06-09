// ignore_for_file: file_names

class ReportCrop {
  String description;
  String date;
  double value;

  ReportCrop(
      {required this.description, required this.date, required this.value});

  @override
  toString() {
    return "{\"description\":"
        "\"$description\","
        "\"date\":"
        "\"$date\","
        "\"value\":"
        "\"$value\"}";
  }

  factory ReportCrop.fromJson(Map<String, dynamic> json) {
    return ReportCrop(
        description: json['description'],
        date: json['date'],
        value: json['value'].toDouble());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['date'] = date;
    data['value'] = value;
    return data;
  }
}
