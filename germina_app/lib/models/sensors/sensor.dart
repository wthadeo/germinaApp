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

  factory Sensor.fromJson(dynamic json) {
    return Sensor(
        name: json['name'] as String,
        protocol: json['protocol'] as String,
        uri: json['uri'] as String,
        category: json['category'] as String
        );
  }

}
