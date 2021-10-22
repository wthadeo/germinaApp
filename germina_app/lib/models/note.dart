class Note{

  String name;
  String description;
  String date;

  Note({required this.name, required this.description, required this.date});

  factory Note.fromJson(dynamic json) {
    return Note(
        name: json['name'] as String,
        description: json['description'] as String,
        date: json['date'] as String);
  }
}