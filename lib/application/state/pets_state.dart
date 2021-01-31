import 'package:flutter/material.dart';
import 'package:uchinoko_project_mobile/infrastructure/model/pet_model.dart';

class PetsState {
  final bool isLoading;
  final List<PetModel> pets;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const PetsState({
    @required this.isLoading,
    @required this.pets,
  });

  PetsState copyWith({
    bool isLoading,
    List<PetModel> pets,
  }) {
    if ((isLoading == null || identical(isLoading, this.isLoading)) &&
        (pets == null || identical(pets, this.pets))) {
      return this;
    }

    return new PetsState(
      isLoading: isLoading ?? this.isLoading,
      pets: pets ?? this.pets,
    );
  }

  @override
  String toString() {
    return 'PetsState{isLoading: $isLoading, pets: $pets}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetsState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          pets == other.pets);

  @override
  int get hashCode => isLoading.hashCode ^ pets.hashCode;

  factory PetsState.fromMap(Map<String, dynamic> map) {
    return new PetsState(
      isLoading: map['isLoading'] as bool,
      pets: map['pets'] as List<PetModel>,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'isLoading': this.isLoading,
      'pets': this.pets,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}