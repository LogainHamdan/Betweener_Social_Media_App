import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/constants.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

import '../views_features/auth/login_view.dart';

Future<UserClass> searchByName(
    BuildContext context, Map<String, dynamic> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(Uri.parse(searchUrl),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);

  if (response.statusCode == 200) {
    //Link link = linkFromJson(response.body);
    return UserClass.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error(
      'Search controller: error with status code: ${response.statusCode}');
  //هذا الفنكشن برجعلي من نوع bool بمعنى لقد تمت العملية بنجاح تروووو
}
