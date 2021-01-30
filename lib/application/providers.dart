// Package imports:
import 'package:flutter_riverpod/all.dart';

// Project imports:
import 'package:uchinoko_project_mobile/application/pets_notifier.dart';
import 'package:uchinoko_project_mobile/application/session_notifier.dart';
import 'package:uchinoko_project_mobile/infrastructure/repository/pet_repository.dart';
import 'package:uchinoko_project_mobile/infrastructure/repository/session_repository.dart';
import 'package:uchinoko_project_mobile/infrastructure/service/fetch_api.dart';

final _petRepositoryProvider = Provider<PetModelRepository>(
  (ref) => PetModelRepository(httpService: HttpService()),
);

final petsNotifierProvider = StateNotifierProvider<PetsNotifier>(
  (ref) => PetsNotifier(
    petModelRepository: ref.watch(_petRepositoryProvider),
  ),
);

final _sessionRepositoryProvider = Provider<SessionRepository>(
    (ref) => SessionRepository(httpService: HttpService()),
);

final sessionNotifierProvider = StateNotifierProvider(
    (ref) => SessionNotifier(
      sessionRepository: ref.watch(_sessionRepositoryProvider),
    ),
);
