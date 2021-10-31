class Note{

  String name;
  String description;
  String date;

  Note({required this.name, required this.description, required this.date});

  @override
  toString(){
    return "{\"name\":" +  "\"$name\"," + "\"description\":" +  "\"$description\"," + "\"date\":" + "\"$date\"}";
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
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