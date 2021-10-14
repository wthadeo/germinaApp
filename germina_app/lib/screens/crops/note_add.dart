import 'package:flutter/material.dart';
import 'package:germina_app/communicator/communicator.dart';
import 'package:germina_app/constants.dart';
import 'package:germina_app/models/note.dart';
import 'package:germina_app/repositories/crops_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NoteAdd extends StatefulWidget {
  const NoteAdd({Key? key}) : super(key: key);

  @override
  _NoteAddState createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  late CropsRepository cropRepos;
  String name = '';
  String description = '';
  final dateAtual = DateTime.now();

  Note noteAdded = Note('', '', '');
  List<Note> notes = Communicator.currentCrop.notesCrop;

  @override
  Widget build(BuildContext context) {
    cropRepos = Provider.of<CropsRepository>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Nova Observação",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    name = text;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Nome',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: TextField(
                  onChanged: (text) {
                    description = text;
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    labelText: 'Descrição',
                  )),
            ),
            const SizedBox(
              height: 40.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: primaryColor,
                    minimumSize: const Size(300, 60),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onPressed: () {
                  noteAdded = Note(name, description,
                      DateFormat('yyyy-MM-dd').format(dateAtual).toString());
                  cropRepos.saveNote(noteAdded, Communicator.currentCrop);
                  Navigator.pop(context);
                },
                child: const Text('Adicionar Observação'))
          ],
        ),
      ),
    );
  }
}
