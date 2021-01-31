// Package imports:
import 'package:flutter_riverpod/all.dart';

// Project imports:
import 'package:uchinoko_project_mobile/application/controller/pets_notifier.dart';
import 'package:uchinoko_project_mobile/application/controller/session_notifier.dart';
import 'package:uchinoko_project_mobile/application/controller/timeline_notifier.dart';
import 'package:uchinoko_project_mobile/infrastructure/repository/pet_repository.dart';
import 'package:uchinoko_project_mobile/infrastructure/repository/session_repository.dart';
import 'package:uchinoko_project_mobile/infrastructure/repository/timeline_repository.dart';
import 'package:uchinoko_project_mobile/infrastructure/service/fetch_api.dart';


final _httpService = HttpService();

/// Repository
final _petRepositoryProvider = Provider<PetModelRepository>(
  (ref) => PetModelRepository(httpService: _httpService),
);

final _timelineRepositoryProvider = Provider<TimelineRepository>(
    (ref) => TimelineRepository(httpService: _httpService),
);

final _sessionRepositoryProvider = Provider<SessionRepository>(
      (ref) => SessionRepository(httpService: _httpService),
);


/// Notifier
final petsNotifierProvider = StateNotifierProvider<PetsNotifier>(
  (ref) => PetsNotifier(
    petModelRepository: ref.watch(_petRepositoryProvider),
  ),
);

final sessionNotifierProvider = StateNotifierProvider(
    (ref) => SessionNotifier(
      sessionRepository: ref.watch(_sessionRepositoryProvider),
    ),
);

final timelineNotifierProvider = StateNotifierProvider(
    (ref) => TimelineNotifier(
      timelineRepository: ref.watch(_timelineRepositoryProvider),
    ),
);