class Notification{
  
  String name;
  String description;
  String date;

  Notification({required this.name, required this.description, required this.date});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
        name: json['name'],
        description: json['description'],
        date: json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    data['date'] = date;
    return data;
  }
  

}