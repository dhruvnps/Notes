import 'dart:io';
import 'dart:convert';
import 'package:notes/services/note.dart';

class Data {
  static List<Note> notes = [];
  static File file;
  static Directory dir;
  static String fileName = 'notes_file.json';
  static bool fileExists = false;

  static void readFileToList() {
    List<dynamic> notes = json.decode(file.readAsStringSync());
    Data.notes = Note.fromJsonDecode(notes);
  }

  static void writeToFile() {
    if (fileExists) {
      file.writeAsStringSync(json.encode(notes));
    } else {
      createFile();
    }
  }

  static void createFile() {
    file = File(dir.path + '/' + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(notes));
  }

  static void removeEmptyNotes() {
    notes = notes
        .where((note) =>
            (note.title.trim() != '' || note.text.trim() != ''))
        .toList();
  }
}
