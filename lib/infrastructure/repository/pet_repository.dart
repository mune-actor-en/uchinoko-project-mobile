// Project imports:
import 'dart:io';

import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';
import 'package:uchinoko_project_mobile/infrastructure/service/fetch_api.dart';

class PetModelRepository {
  const PetModelRepository({this.httpService});
  final HttpService httpService;

  Future<List<PetModel>> fetchPets() async {
    try {
      final extractedData = await httpService.fetchPets();
      List<PetModel> pets = [];
      extractedData.forEach((element) {
        pets.add(PetModel.fromMap(element));
      });
    return pets;
    } catch(error) {
      return Future.error(error);
    }
  }

  Future<void> createPet(PetModel pet, String jwt) async {
    try {
      final int statusCode = await httpService.createPet(pet, jwt);
      if (statusCode == HttpStatus.created){
        print('A pet is created.');
        return;
      } else {
        return Future.error('err');
      }
    } catch(error) {
      return Future.error(error);
    }
  }
}

