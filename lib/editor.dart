import 'package:flutter/material.dart';
import 'package:notes/services/theme.dart';
import 'package:notes/services/data.dart';
import 'package:notes/services/info_sheet.dart';

class Editor extends StatefulWidget {
  final int noteIndex;
  Editor(this.noteIndex);

  @override
  EditorState createState() => EditorState(noteIndex);
}

class EditorState extends State<Editor> {
  final int noteIndex;
  EditorState(this.noteIndex);

  FocusNode textFocusNode;
  FocusNode titleFocusNode;
  bool isInfoOpen = false;

  @override
  void initState() {
    super.initState();
    textFocusNode = FocusNode();
    titleFocusNode = FocusNode();
  }

  @override
  void dispose() {
    textFocusNode.dispose();
    titleFocusNode.dispose();
    super.dispose();
  }

  void updateData({
    String text,
    String title,
    bool isDeleted,
  }) {
    if (text != null) {
      Data.notes[noteIndex].text = text;
    }
    if (title != null) {
      Data.notes[noteIndex].title = title;
    }
    if (isDeleted != null) {
      Data.notes[noteIndex].isDeleted = isDeleted;
    }
    Data.notes[noteIndex].dateModified = DateTime.now();
    Data.writeToFile();
  }

  void closeInfoOnTapOutside({FocusNode focusNode}) {
    if (isInfoOpen) {
      setState(() {
        if (focusNode != null) {
          focusNode.unfocus();
        }
        isInfoOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isInfoOpen) {
          setState(() => isInfoOpen = false);
        } else {
          Navigator.pop(context, true);
        }
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
              onPressed: () {
                setState(() {
                  isInfoOpen = !isInfoOpen;
                  textFocusNode.unfocus();
                  titleFocusNode.unfocus();
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                updateData(isDeleted: true);
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
                onTap: () => closeInfoOnTapOutside(),
                autofocus: Data.notes[noteIndex].title == '',
                focusNode: titleFocusNode,
                initialValue: Data.notes[noteIndex].title,
                onChanged: (title) {
                  updateData(title: title.trim());
                },
                onFieldSubmitted: (_) => textFocusNode.requestFocus(),
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
                  onTap: () =>
                      closeInfoOnTapOutside(focusNode: textFocusNode),
                  focusNode: textFocusNode,
                  autofocus: Data.notes[noteIndex].title != '' &&
                      Data.notes[noteIndex].text == '',
                  initialValue: Data.notes[noteIndex].text,
                  onChanged: (text) {
                    updateData(text: text);
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
        bottomNavigationBar: InfoSheet(
          isInfoOpen: isInfoOpen,
          noteIndex: noteIndex,
        ),
      ),
    );
  }
}
