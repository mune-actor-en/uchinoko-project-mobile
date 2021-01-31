// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uchinoko_project_mobile/application/state/pets_state.dart';

// Project imports:
import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';
import 'package:uchinoko_project_mobile/infrastructure/repository/pet_repository.dart';

class PetsNotifier extends StateNotifier<PetsState> {
  PetsNotifier({this.petModelRepository}) : super(_initState);

  final PetModelRepository petModelRepository;

  static const PetsState _initState = PetsState(isLoading: false, pets: []);

  Future<void> fetchPets() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(Duration(milliseconds: 300));
    final List<PetModel> pets = await petModelRepository.fetchPets();
    state = state.copyWith(pets: pets, isLoading: false);
  }

  Future<void> createPet(PetModel pet, String jwt) async {
    state = state.copyWith(isLoading: true);
    await petModelRepository.createPet(pet, jwt);
    state = state.copyWith(isLoading: false);
  }
}
