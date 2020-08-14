import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:notes/services/data.dart';
import 'package:notes/services/note.dart';
import 'package:notes/services/note_widget.dart';
import 'package:notes/services/theme.dart';
import 'package:notes/editor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MaterialApp(
      home: Home(),
      theme: darkTheme,
    ));
  });
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  void openNote({int noteIndex}) async {
    if (noteIndex == null) {
      Data.notes.add(Note(title: "", text: "", isDeleted: false));
    }
    var result = await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) {
        if (noteIndex == null) {
          noteIndex = Data.notes.length - 1;
        }
        return Editor(noteIndex);
      }),
    );
    if (result) {
      setState(() {
        Data.removeEmptyNotes();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory dir) {
      Data.dir = dir;
      Data.file = File(dir.path + '/' + Data.fileName);
      Data.fileExists = Data.file.existsSync();
      if (Data.fileExists) {
        setState(() => Data.readFileToList());
      } else {
        Data.createFile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNote(),
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Data.notes.where((note) => !note.isDeleted).length > 0
            ? ListView.builder(
                itemCount: Data.notes.length,
                itemBuilder: (context, index) {
                  return Data.notes[index].isDeleted
                      ? SizedBox.shrink()
                      : Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [
                            InkWell(
                              onTap: () => openNote(noteIndex: index),
                              onLongPress: () => print('long press'),
                              child: NoteWidget(Data.notes[index]),
                            ),
                            Divider(height: 0),
                          ],
                        );
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.note_add,
                      size: 100,
                      color: Colors.grey[800],
                    ),
                    Text(
                      'Create\nnote',
                      style: TextStyle(color: Colors.grey[800]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
      ),
    );
  }
}
