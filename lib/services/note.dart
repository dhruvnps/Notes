class Note {
  String text;
  String title;
  bool isDeleted;

  Note({
    this.title,
    this.text,
    this.isDeleted,
  });

  Map toJson() => {
        'text': text,
        'title': title,
        'isDeleted': isDeleted,
      };

  static List<Note> fromJsonDecode(List<dynamic> notes) {
    List<Note> notesList = new List<Note>();
    for (dynamic note in notes) {
      notesList.add(Note(
        title: note['title'],
        text: note['text'],
        isDeleted: note['isDeleted'],
      ));
    }
    return notesList;
  }
}
