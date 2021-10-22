import 'package:germina_app/models/note.dart';

class Crop {
  String name;
  String age;
  int qntOfPlants;
  bool isActive;
  List<Note> notesCrop = [];

  Crop(
      {required this.name,
      required this.age,
      required this.qntOfPlants,
      required this.isActive,
      required this.notesCrop});

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
    }
  }
}
