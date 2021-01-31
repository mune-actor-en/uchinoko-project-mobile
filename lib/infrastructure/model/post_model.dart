import 'package:flutter/material.dart';

class PostModel {
  final String imagePath;
  final String description;
  final bool isPublished;
  final int userId;
  final int petId;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const PostModel({
    @required this.imagePath,
    @required this.description,
    @required this.isPublished,
    @required this.userId,
    @required this.petId,
  });

  PostModel copyWith({
    String imagePath,
    String description,
    bool isPublished,
    int userId,
    int petId,
  }) {
    if ((imagePath == null || identical(imagePath, this.imagePath)) &&
        (description == null || identical(description, this.description)) &&
        (isPublished == null || identical(isPublished, this.isPublished)) &&
        (userId == null || identical(userId, this.userId)) &&
        (petId == null || identical(petId, this.petId))) {
      return this;
    }

    return new PostModel(
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      isPublished: isPublished ?? this.isPublished,
      userId: userId ?? this.userId,
      petId: petId ?? this.petId,
    );
  }

  @override
  String toString() {
    return 'PostModel{imagePath: $imagePath, description: $description, isPublished: $isPublished, userId: $userId, petId: $petId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostModel &&
          runtimeType == other.runtimeType &&
          imagePath == other.imagePath &&
          description == other.description &&
          isPublished == other.isPublished &&
          userId == other.userId &&
          petId == other.petId);

  @override
  int get hashCode =>
      imagePath.hashCode ^
      description.hashCode ^
      isPublished.hashCode ^
      userId.hashCode ^
      petId.hashCode;

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return new PostModel(
      imagePath: map['imagePath'] as String,
      description: map['description'] as String,
      isPublished: map['isPublished'] as bool,
      userId: map['userId'] as int,
      petId: map['petId'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'imagePath': this.imagePath,
      'description': this.description,
      'isPublished': this.isPublished,
      'userId': this.userId,
      'petId': this.petId,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}