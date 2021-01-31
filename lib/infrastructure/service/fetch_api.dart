// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';
import 'package:uchinoko_project_mobile/infrastructure/model/post_model.dart';

class HttpService {
  static const headers = {
    HttpHeaders.contentTypeHeader: "application/json",
  };

  _createRequestHeaders(String jwt) {
    return {
      HttpHeaders.contentTypeHeader: "application/json",
      // HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
    };
  }

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

  Future<List<dynamic>> fetchPosts() async {
    final response = await http
        .get('http://localhost:8080/api/v1/posts')
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

  Future<int> createPet(PetModel pet, String jwt) async {
    final body = json.encode(pet.toMap());
    print('Pet will be created by $body');

    final response = await http
        .post(
          'http://localhost:8080/api/v1/pets',
          headers: _createRequestHeaders(jwt),
          body: body,
        )
        .timeout(Duration(seconds: 9));

    print(response.statusCode);
    return response.statusCode;
  }

  Future<int> createPost(PostModel post, String jwt) async {
    final body = json.encode(post.toMap());
    print('Post will be created by $body');

    final response = await http
        .post(
          'http://localhost:8080/api/v1/posts',
          headers: _createRequestHeaders(jwt),
          body: body,
        )
        .timeout(Duration(seconds: 9));

    print(response.statusCode);
    return response.statusCode;
  }
}
