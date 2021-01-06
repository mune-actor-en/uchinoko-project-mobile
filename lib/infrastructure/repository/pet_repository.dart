import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';
import 'package:uchinoko_project_mobile/infrastructure/service/fetch_api.dart';

class PetModelRepository {
  const PetModelRepository({this.httpService});
  final HttpService httpService;

  Future<List<PetModel>> fetchPets() async {
    try {
      print("============ 003 01 ============");
      final extractedData = await httpService.fetchPets();
      print("============ 003 02 ============");
      List<PetModel> pets = [];
      extractedData.forEach((element) {
        pets.add(PetModel.fromMap(element));
      });
    return pets;
    } catch(error) {
      return Future.error(error);
    }
  }
}

