// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';
import 'package:uchinoko_project_mobile/infrastructure/repository/pet_repository.dart';

abstract class PetsState {
  const PetsState();
}

class PetsInitial extends PetsState {
  const PetsInitial();
}

class PetsLoading extends PetsState {
  const PetsLoading();
}

class PetsLoaded extends PetsState {
  const PetsLoaded({@required this.pets});

  final List<PetModel> pets;
}

class PetsError extends PetsState {
  const PetsError({this.errorMessage = "Something error"});

  final String errorMessage;
}

class PetsNotifier extends StateNotifier<PetsState> {
  PetsNotifier({this.petModelRepository}) : super(PetsInitial());

  final PetModelRepository petModelRepository;

  Future<void> fetchPets() async {
    try {
      await Future.delayed(Duration(milliseconds: 3000));
      state = PetsLoading();
      final List<PetModel> pets = await petModelRepository.fetchPets();
      state = PetsLoaded(pets: pets);
    } on Exception {
      state = PetsError(
        errorMessage: "Couldn't fetch weather. Is the device online?",
      );
    }
  }

  Future<void> createPet() async {
    try {

    } on Exception {
      
    }
  }
}
