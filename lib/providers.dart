import 'package:flutter_riverpod/all.dart';
import 'package:uchinoko_project_mobile/application/pets_notifier.dart';
import 'package:uchinoko_project_mobile/infrastructure/repository/pet_repository.dart';
import 'package:uchinoko_project_mobile/infrastructure/service/fetch_api.dart';

final _petRepositoryProvider = Provider<PetModelRepository>(
  (ref) => PetModelRepository(httpService: HttpService()),
);

final petsNotifierProvider = StateNotifierProvider(
  (ref) => PetsNotifier(
    petModelRepository: ref.watch(_petRepositoryProvider),
  ),
);
