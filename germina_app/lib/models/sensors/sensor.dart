class Sensor {
  String name;
  String protocol;
  String uri;
  String category;

  Sensor(
      {required this.name,
      required this.protocol,
      required this.uri,
      required this.category});

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
        name: json['name'],
        protocol: json['protocol'],
        uri: json['uri'],
        category: json['category']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['protocol'] = protocol;
    data['uri'] = uri;
    data['category'] = category;
    return data;
  }

}
