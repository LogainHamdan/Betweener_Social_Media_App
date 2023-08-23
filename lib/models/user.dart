// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
import 'package:tt9_betweener_challenge/models/link.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  UserClass? user;
  String? token;

  User({
    this.user,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class UserClass {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? isActive;
  dynamic country;
  dynamic ip;
  dynamic long;
  dynamic lat;
  List<Link>? links;

  UserClass({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.country,
    this.ip,
    this.long,
    this.lat,
    this.links,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isActive: json["isActive"],
        country: json["country"],
        ip: json["ip"],
        long: json["long"],
        lat: json["lat"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "isActive": isActive,
        "country": country,
        "ip": ip,
        "long": long,
        "lat": lat,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
      };
}
