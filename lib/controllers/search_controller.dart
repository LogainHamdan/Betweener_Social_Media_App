import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/constants.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

Future<List<UserClass>> searchByName(Map<String, dynamic> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(Uri.parse(searchUrl),
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${user.token}'},
      body: body);

  if (response.statusCode == 200) {
    dynamic responseJson = jsonDecode(response.body);
    List<UserClass> users = [];

//حطيت dynamic  عشان نوع اليوزر تحت صار فيه كونفليكت
    for (dynamic user in responseJson['user']) {
      users.add(UserClass.fromJson(user));
    }
    return users;
  }
  return Future.error(
      'Search controller: error with status code: ${response.statusCode}');
}
