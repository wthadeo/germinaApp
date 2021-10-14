import 'package:germina_app/models/note.dart';

class Crop{

  String name;
  String age;
  int qntOfPlants;
  bool isActive;
  late List<Note> notesCrop = [];

  Crop(this.name, this.age, this.qntOfPlants, this.isActive, this.notesCrop);

}