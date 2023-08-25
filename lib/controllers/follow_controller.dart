import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../core/utils/constants.dart';
import '../models/follow.dart';
import '../models/user.dart';

Future<FollowModel> getFollow() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  ///return the user in the system and convert it to user model

  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  if (response.statusCode == 200) {
    return followModelFromJson(response.body);
  }

  return Future.error('follow controller: Something went wrong');
}

Future<bool> addFollow(Map<String, dynamic> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);

  if (response.statusCode == 200) {
    FollowModel followModel = followModelFromJson(response.body);
    return true;
  }

  return Future.error('Add: Something wrong');
  //هذا الفنكشن برجعلي من نوع bool بمعنى لقد تمت العملية بنجاح تروووو
}
