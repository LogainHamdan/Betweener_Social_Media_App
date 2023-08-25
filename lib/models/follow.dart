// To parse this JSON data, do
//
//     final followModel = followModelFromJson(jsonString);

import 'dart:convert';

//أول سطر بالمودل هو اللي بخليني اعرف شو بترجعلي عشان ابني الكنترولر

FollowModel followModelFromJson(String str) =>
    FollowModel.fromJson(json.decode(str));

String followModelToJson(FollowModel data) => json.encode(data.toJson());

class FollowModel {
  int? followingCount;
  int? followersCount;
  List<Follow>? following;
  List<Follow>? followers;

  FollowModel({
    this.followingCount,
    this.followersCount,
    this.following,
    this.followers,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
        followingCount: json["following_count"],
        followersCount: json["followers_count"],
        following: json["following"] == null
            ? []
            : List<Follow>.from(json["following"]!.map((x) => x)),
        followers: json["followers"] == null
            ? []
            : List<Follow>.from(
                json["followers"]!.map((x) => Follow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "following_count": followingCount,
        "followers_count": followersCount,
        "following": following == null
            ? []
            : List<dynamic>.from(following!.map((x) => x)),
        "followers": followers == null
            ? []
            : List<dynamic>.from(followers!.map((x) => x.toJson())),
      };
}

class Follow {
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

  Follow({
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
  });

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
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
      };
}
