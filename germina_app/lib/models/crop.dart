import 'package:germina_app/models/note.dart';

class Crop {
  String name;
  String age;
  int qntOfPlants;
  bool isActive;
  List<Note> notesCrop;

  Crop(
      {required this.name,
      required this.age,
      required this.qntOfPlants,
      required this.isActive,
      required this.notesCrop});

  factory Crop.fromJson(Map<String, dynamic> json) {
    var listNotes = json['notesCrop'] as List;

    List<Note> _notesCrop = listNotes.map((v) => Note.fromJson(v)).toList();

    return Crop(
        name: json['name'],
        age: json['age'],
        qntOfPlants: json['qntOfPlants'],
        isActive: json['isActive'],
        notesCrop: _notesCrop);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['age'] = age;
    data['qntOfPlants'] = qntOfPlants;
    data['isActive'] = isActive;
    data['notesCrop'] = notesCrop.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  toString() {
    return "\"name\":"
        "\"$name\","
        "\"age\":"
        "\"$age\","
        "\"qntOfPlants\":"
        "$qntOfPlants,"
        "\"isActive\":"
        " $isActive,"
        "\"notesCrop\":"
        "${notesCrop.toString()}";
  }
  /*

  factory Crop.fromJson(dynamic json) {
    if (json['notesCrop'] != null) {
      var noteObjsJson = json['notesCrop'] as List;
      List<Note> _notes =
          noteObjsJson.map((noteJson) => Note.fromJson(noteJson)).toList();

      return Crop(
          name: json['name'] as String,
          age: json['age'] as String,
          qntOfPlants: json['qntOfPlants'] as int,
          isActive: json['isActive'] as bool,
          notesCrop: _notes);
    } else {
      return Crop(
          name: json['name'] as String,
          age: json['age'] as String,
          qntOfPlants: json['qntOfPlants'] as int,
          isActive: json['isActive'] as bool,
          notesCrop: []);
    }*/
}
