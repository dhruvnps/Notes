import 'package:flutter/material.dart';
import 'package:notes/services/note.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  NoteWidget(this.note);

  String noteText() {
    RegExp blankSpace = RegExp(r'\n\s*\n');
    String text = note.text.replaceAll(blankSpace, '\n').trim();
    return text != '' ? text : null;
  }

  String noteTitle() {
    String title = note.title.trim();
    return title != '' ? title : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              noteTitle() != null ? noteTitle() : 'untitled',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: noteTitle() != null
                  ? Theme.of(context).textTheme.subtitle1
                  : Theme.of(context).textTheme.bodyText1,
            ),
            noteText() != null
                ? Column(
                    children: [
                      SizedBox(height: 5),
                      Text(
                        noteText(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
