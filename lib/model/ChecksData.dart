// To parse this JSON data, do
//
//     final checksData = checksDataFromJson(jsonString);

import 'dart:convert';

ChecksData checksDataFromJson(String str) => ChecksData.fromJson(json.decode(str));

String checksDataToJson(ChecksData data) => json.encode(data.toJson());

class ChecksData {
  List<Check> checks;

  ChecksData({
    this.checks,
  });

  factory ChecksData.fromJson(Map<String, dynamic> json) => new ChecksData(
    checks: new List<Check>.from(json["checks"].map((x) => Check.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "checks": new List<dynamic>.from(checks.map((x) => x.toJson())),
  };
}

class Check {
  String category;
  int nb;
  String image;
  String description;

  Check({
    this.category,
    this.nb,
    this.image,
    this.description,
  });

  factory Check.fromJson(Map<String, dynamic> json) => new Check(
    category: json["category"],
    nb: json["nb"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "nb": nb,
    "image": image,
    "description": description,
  };
}
