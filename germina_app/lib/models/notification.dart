class Notification{
  
  String name;
  String description;
  String date;

  Notification({required this.name, required this.description, required this.date});

  factory Notification.fromJson(dynamic json) {
    return Notification(
        name: json['name'] as String,
        description: json['description'] as String,
        date: json['date'] as String);
  }
  

}