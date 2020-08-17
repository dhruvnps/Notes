import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:notes/services/data.dart';
import 'package:notes/services/note.dart';
import 'package:notes/services/note_widget.dart';
import 'package:notes/services/theme.dart';
import 'package:notes/services/side_nav.dart';
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
  static bool isTrash = false;

  List<String> trashOptions = ['Empty Trash'];
  void trashOptionAction(String option) {
    if (option == 'Empty Trash') {
      setState(() => Data.emptyTrash());
    }
  }

  void openNote({int noteIndex}) async {
    if (noteIndex == null) {
      Data.notes.add(Note(
        title: '',
        text: '',
        isDeleted: false,
        dateCreated: DateTime.now(),
        dateModified: DateTime.now(),
      ));
    }
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        if (noteIndex == null) {
          noteIndex = Data.notes.length - 1;
        }
        return Editor(noteIndex);
      }),
    );
    if (result) {
      setState(() {});
    }
  }

  void showTrashDialog({int noteIndex}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Restore Note?',
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: 20,
              ),
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'No',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => Data.notes[noteIndex].isDeleted = false);
            },
            child: Text(
              'Yes',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory dir) {
      Data.dir = dir;
      Data.file = File(dir.path + '/' + Data.fileName);
      Data.fileExists = Data.file.existsSync();
      if (Data.fileExists) {
        setState(() {
          Data.readFileToList();
          Data.removeEmptyNotes();
        });
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
          isTrash ? 'Trash' : 'Notes',
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: [
          isTrash
              ? PopupMenuButton<String>(
                  onSelected: trashOptionAction,
                  itemBuilder: (BuildContext context) {
                    return trashOptions.map((option) {
                      return PopupMenuItem(
                        value: option,
                        child: Text(option),
                      );
                    }).toList();
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
        ],
      ),
      drawer: SideNav(this),
      floatingActionButton: !isTrash
          ? FloatingActionButton(
              onPressed: () => openNote(),
              child: Icon(Icons.add),
            )
          : SizedBox.shrink(),
      body: Container(
        child: Data.notes
                .where((note) =>
                    note.isDeleted == isTrash &&
                    !Data.isNoteEmpty(note))
                .isNotEmpty
            ? ListView.builder(
                itemCount: Data.notes.length,
                itemBuilder: (context, index) {
                  return Data.notes[index].isDeleted == isTrash &&
                          !Data.isNoteEmpty(Data.notes[index])
                      ? Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [
                            InkWell(
                              onTap: isTrash
                                  ? () => showTrashDialog(
                                      noteIndex: index)
                                  : () => openNote(noteIndex: index),
                              onLongPress: () => print('long press'),
                              child: NoteWidget(Data.notes[index]),
                            ),
                            Divider(height: 0),
                          ],
                        )
                      : SizedBox.shrink();
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isTrash ? Icons.delete : Icons.note_add,
                      size: 100,
                      color: Colors.grey[800],
                    ),
                    Text(
                      isTrash ? 'Nothing\nhere' : 'Create\nnote',
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
