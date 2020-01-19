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
  String icon;
  List<String> images;
  String title;
  String description;

  Check({
    this.category,
    this.nb,
    this.icon,
    this.images,
    this.title,
    this.description,
  });

  factory Check.fromJson(Map<String, dynamic> json) => new Check(
    category: json["category"],
    nb: json["nb"],
    icon: json["icon"],
    images: new List<String>.from(json["images"].map((x) => x)),
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "nb": nb,
    "icon": icon,
    "images": new List<dynamic>.from(images.map((x) => x)),
    "title": title,
    "description": description,
  };
}
