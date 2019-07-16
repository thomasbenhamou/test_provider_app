import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
  int id;
  String content;
  int checklistid;

  Note({
    this.id,
    this.content,
    this.checklistid,
  });

  factory Note.fromJson(Map<String, dynamic> json) => new Note(
        id: json["id"],
        content: json["content"],
        checklistid: json["checklistid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "checklistid": checklistid,
      };
}
