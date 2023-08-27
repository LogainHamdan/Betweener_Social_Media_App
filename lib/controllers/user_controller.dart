import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../core/utils/constants.dart';
import '../models/user.dart';
import '../views_features/profile/profile_view.dart';

Future<User> getLocalUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('user')) {
    return userFromJson(prefs.getString('user')!);
  }

  return Future.error('not found');
}

Future<bool> UpdateUser(
    BuildContext context, Map<String, dynamic> body, String id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.put(Uri.parse('$updateUrl/$id'),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);

  if (response.statusCode == 200) {
    User link = userFromJson(response.body);

    return true;
  } else if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, ProfileView.id);
  }

  return Future.error('Update info: Something wrong');
}
