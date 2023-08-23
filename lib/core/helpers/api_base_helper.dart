import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'app_exception.dart';

class ApiBaseHelper {
  Future<dynamic> get(String url, Map<String, String> header) async {
    var responseJson;
    try {
      final response =
          await http.get(Uri.parse(baseUrl + url), headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet conncetion');
    }
  }

  Future<dynamic> post(
      String url, Map<String, dynamic> body, Map<String, String> header) async {
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(url), headers: header, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No internet conncetion');
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
