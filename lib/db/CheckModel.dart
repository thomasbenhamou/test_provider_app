import 'dart:convert';

Check checkFromJson(String str) => Check.fromJson(json.decode(str));

String checkToJson(Check data) => json.encode(data.toJson());

class Check {
  int id;
  String category;
  int nb;
  bool state;
  int checklistid;

  Check({
    this.id,
    this.category,
    this.nb,
    this.state,
    this.checklistid,
  });

  factory Check.fromJson(Map<String, dynamic> json) => new Check(
        id: json["id"],
        category: json["category"],
        nb: json["nb"],
        state: json["state"] == 0 ? false : true,
        checklistid: json["checklistid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "nb": nb,
        "state": state,
        "checklistid": checklistid,
      };
}
