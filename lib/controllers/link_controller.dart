import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/constants.dart';
import '../models/link.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../views_features/auth/login_view.dart';

Future<List<Link>> getLinks(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  ///return the user in the system and convert it to user model

  final response = await http.get(Uri.parse(linksUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  /// when required to add new link must authorized previously so we use header

  print(jsonDecode(response.body)['links']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['links'] as List<dynamic>;

    return data.map((e) => Link.fromJson(e)).toList();
  }

  if (response.statusCode == 401) {
    /// if the token wrong or the session ended
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}

Future<bool> addNewLink(BuildContext context, Map<String, dynamic> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(Uri.parse(linksUrl),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);

  if (response.statusCode == 200) {
    Link link = linkFromJson(response.body);

    return true;
  } else if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Something wrong');
  //هذا الفنكشن برجعلي من نوع bool بمعنى لقد تمت العملية بنجاح تروووو
}

Future<bool> editNewLink(
    BuildContext context, Map<String, dynamic> body, String id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.put(Uri.parse('$editLinkUrl/$id'),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);

  if (response.statusCode == 200) {
    Link link = linkFromJson(response.body);

    return true;
  } else if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Something wrong');
}

Future<bool> deleteTheLink(int? id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.delete(
      Uri.parse('https://betweener.gsgtt.tech/api/links/$id'),
      headers: {'Authorization': 'Bearer ${user.token}'});

  if (response.statusCode == 200) {
    return true;
  }

  return Future.error('Something wrong');
}
