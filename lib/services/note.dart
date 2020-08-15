class Note {
  String text;
  String title;
  bool isDeleted;
  DateTime dateCreated;
  DateTime dateModified;

  Note({
    this.title,
    this.text,
    this.isDeleted,
    this.dateCreated,
    this.dateModified,
  });

  Map toJson() => {
        'text': text,
        'title': title,
        'isDeleted': isDeleted,
        'dateCreated': dateCreated.millisecondsSinceEpoch,
        'dateModified': dateModified.millisecondsSinceEpoch,
      };

  static List<Note> fromJsonDecode(List<dynamic> notes) {
    List<Note> notesList = new List<Note>();
    for (dynamic note in notes) {
      notesList.add(Note(
        title: note['title'],
        text: note['text'],
        isDeleted: note['isDeleted'],
        dateCreated:
            DateTime.fromMillisecondsSinceEpoch(note['dateCreated']),
        dateModified:
            DateTime.fromMillisecondsSinceEpoch(note['dateModified']),
      ));
    }
    return notesList;
  }
}
