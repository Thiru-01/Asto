// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(Map<String, dynamic> str) =>
    DataModel.fromJson(str);

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.room1,
  });

  Room1? room1;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        room1: Room1.fromJson(Map<String, String>.from(json["room1"])),
      );

  Map<String, dynamic> toJson() => {
        "room1": room1!.toJson(),
      };
}

class Room1 {
  Room1({
    this.fan,
    this.light,
  });

  String? fan;
  String? light;

  factory Room1.fromJson(Map<String, dynamic> json) => Room1(
        fan: json["fan"],
        light: json["light"],
      );

  Map<String, dynamic> toJson() => {
        "fan": fan,
        "light": light,
      };
}
