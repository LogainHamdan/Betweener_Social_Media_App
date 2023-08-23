// To parse this JSON data, do
//
//     final link = linkFromJson(jsonString);

import 'dart:convert';

import 'package:tt9_betweener_challenge/models/user.dart';

Link linkFromJson(String str) => Link.fromJson(json.decode(str));

String linkToJson(Link data) => json.encode(data.toJson());

class Link {
  int? id;
  String? title;
  String? link;
  String? username;
  String? isActive;
  String? userId;
  String? createdAt;
  String? updatedAt;

  Link({
    this.id,
    this.title,
    this.link,
    this.username,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        username: json["username"],
        isActive: json["isActive"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "username": username,
        "isActive": isActive,
        "user_id": userId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
