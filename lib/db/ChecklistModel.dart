import 'dart:convert';

Checklist checklistFromJson(String str) => Checklist.fromJson(json.decode(str));

String checklistToJson(Checklist data) => json.encode(data.toJson());

class Checklist {
  int id;
  String name;

  Checklist({
    this.id,
    this.name,
  });

  setName(String name) {
    this.name = name;
  }

  factory Checklist.fromJson(Map<String, dynamic> json) => new Checklist(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
