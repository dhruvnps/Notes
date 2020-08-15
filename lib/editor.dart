import 'package:flutter/material.dart';
import 'package:notes/services/theme.dart';
import 'package:notes/services/data.dart';

class Editor extends StatefulWidget {
  final int noteIndex;
  Editor(this.noteIndex);

  @override
  EditorState createState() => EditorState(noteIndex);
}

class EditorState extends State<Editor> {
  final int noteIndex;
  EditorState(this.noteIndex);

  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, true),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                Data.notes[noteIndex].isDeleted = true;
                Data.writeToFile();
                Navigator.pop(context, true);
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: Column(
            children: [
              TextFormField(
                autofocus: Data.notes[noteIndex].title == '',
                initialValue: Data.notes[noteIndex].title,
                onChanged: (title) {
                  Data.notes[noteIndex].title = title.trim();
                  Data.writeToFile();
                },
                onFieldSubmitted: (_) => focusNode.requestFocus(),
                maxLines: 1,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                cursorColor: cursorColor,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                ),
              ),
              Expanded(
                child: TextFormField(
                  focusNode: focusNode,
                  autofocus: Data.notes[noteIndex].title != '',
                  initialValue: Data.notes[noteIndex].text,
                  onChanged: (text) {
                    Data.notes[noteIndex].text = text;
                    Data.writeToFile();
                  },
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  cursorColor: cursorColor,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Stuff...',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
