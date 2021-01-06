import 'package:flutter/material.dart';

class PetModel {

  final int id;
  final String createdAt;
  final String updatedAt;
  final String birthday;
  final String pickupDate;
  final String name;
  final String imagePath;
  final String sex;
  final int userId;

  //<editor-fold desc="Data Methods" defaultstate="collapsed">

  const PetModel({
    @required this.id,
    @required this.createdAt,
    @required this.updatedAt,
    this.birthday,
    this.pickupDate,
    @required this.name,
    @required this.imagePath,
    this.sex,
    @required this.userId,
  });

  PetModel copyWith({
    int id,
    String createdAt,
    String updatedAt,
    String birthday,
    String pickupDate,
    String name,
    String imagePath,
    String sex,
    int userId,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (createdAt == null || identical(createdAt, this.createdAt)) &&
        (updatedAt == null || identical(updatedAt, this.updatedAt)) &&
        (birthday == null || identical(birthday, this.birthday)) &&
        (pickupDate == null || identical(pickupDate, this.pickupDate)) &&
        (name == null || identical(name, this.name)) &&
        (imagePath == null || identical(imagePath, this.imagePath)) &&
        (sex == null || identical(sex, this.sex)) &&
        (userId == null || identical(userId, this.userId))) {
      return this;
    }

    return new PetModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      birthday: birthday ?? this.birthday,
      pickupDate: pickupDate ?? this.pickupDate,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      sex: sex ?? this.sex,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'PetModel{id: $id, createdAt: $createdAt, updatedAt: $updatedAt, birthday: $birthday, pickupDate: $pickupDate, name: $name, imagePath: $imagePath, sex: $sex, userId: $userId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          birthday == other.birthday &&
          pickupDate == other.pickupDate &&
          name == other.name &&
          imagePath == other.imagePath &&
          sex == other.sex &&
          userId == other.userId);

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      birthday.hashCode ^
      pickupDate.hashCode ^
      name.hashCode ^
      imagePath.hashCode ^
      sex.hashCode ^
      userId.hashCode;

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return new PetModel(
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      birthday: map['birthday'] as String,
      pickupDate: map['pickupDate'] as String,
      name: map['name'] as String,
      imagePath: map['imagePath'] as String,
      sex: map['sex'] as String,
      userId: map['userId'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'birthday': this.birthday,
      'pickupDate': this.pickupDate,
      'name': this.name,
      'imagePath': this.imagePath,
      'sex': this.sex,
      'userId': this.userId,
    } as Map<String, dynamic>;
  }

  //</editor-fold>
}