import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';

class HttpService {
  static List<PetModel> _parsePets(String response) {
    print("============ 003 01 03 01 ============");
    print("response ${response}");
    List<dynamic> l = []; //jsonDecode(response);
    print("============ 003 01 03 02 ============");
    List<PetModel> pets = l.map((e) => PetModel.fromMap(e)).toList();
    print("============ 003 01 03 03 ============");
    return pets;
  }

  Future<List<dynamic>> fetchPets() async {
    print("============ 003 01 01 ============");
    final response = await http
        .get('http://localhost:8080/api/v1/pets')
        .timeout(Duration(seconds: 5));
    print("============ 003 01 02 ============");
    print("status: ${response.statusCode}");
    if (response.statusCode == HttpStatus.ok) {
      print("============ 003 01 03 ============");
      Map<String, dynamic> map = jsonDecode(response.body);
      print("============ 003 01 04 ============");
      // List<dynamic> pets = l["data"].map((e) => PetModel.fromMap(e));
      print("============ 003 01 05 ============");
      // return compute(_parsePets, response.body);
      return map["data"];
    } else {
      throw Exception("Couldn't fetch pets data. Is the device online?");
    }
  }
}