import 'package:germina_app/models/note.dart';

class Crop {
  String name;
  String dateOfCreation;
  String age;
  int qntOfPlants;
  double costOfCrop;
  bool isActive;
  List<Note> notesCrop;

  Crop(
      {required this.name,
      required this.dateOfCreation,
      required this.age,
      required this.qntOfPlants,
      required this.costOfCrop,
      required this.isActive,
      required this.notesCrop});

  factory Crop.fromJson(Map<String, dynamic> json) {
    var listNotes = json['notesCrop'] as List;

    List<Note> _notesCrop = listNotes.map((v) => Note.fromJson(v)).toList();

    return Crop(
        name: json['name'],
        dateOfCreation: json['dateOfCreation'],
        age: json['age'],
        qntOfPlants: json['qntOfPlants'],
        costOfCrop: json['costOfCrop'].toDouble(),
        isActive: json['isActive'],
        notesCrop: _notesCrop);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['dateOfCreation'] = dateOfCreation;
    data['age'] = age;
    data['qntOfPlants'] = qntOfPlants;
    data['costOfCrop'] = costOfCrop;
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
}
