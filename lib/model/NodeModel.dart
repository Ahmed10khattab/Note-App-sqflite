 

class Note {
  static Note note1 = Note();
  int? id;
  String? title;
  String? content;
  DateTime? Creation_date;
  Note({this.id, this.Creation_date, this.content, this.title});

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "content": content,
      "creation_date": Creation_date.toString()
    });
  }

  factory Note.fromMap(note) {
    return Note( id: note['id'],
      title: note['title'],
      content: note['content'],
      Creation_date: note['Creation_date']);
  }
}
