// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:http/http.dart' as http;

class HttpService {
  static const headers = {
    HttpHeaders.contentTypeHeader: "application/json",
  };

  Future<List<dynamic>> fetchPets() async {
    final response = await http
        .get('http://localhost:8080/api/v1/pets')
        .timeout(Duration(seconds: 5));
    print("status: ${response.statusCode}");
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map["data"];
    } else {
      throw Exception("Couldn't fetch pets data. Is the device online?");
    }
  }

  Future<Map<String, dynamic>> login({String email, String password}) async {
    final body = json.encode({"email": email, "password": password});

    final response = await http
        .post(
          'http://localhost:8080/api/v1/auth',
          headers: headers,
          body: body,
        )
        .timeout(Duration(seconds: 9));
    print("status: ${response.statusCode}");
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    } else {
      throw Exception("Couldn't get data. Is the device online?");
    }
  }
}
