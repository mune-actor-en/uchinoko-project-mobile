import 'package:flutter/material.dart';

class SessionModel {
  final String token;
  final int uid;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const SessionModel({
    @required this.token,
    @required this.uid,
  });

  SessionModel copyWith({
    String token,
    int uid,
  }) {
    if ((token == null || identical(token, this.token)) &&
        (uid == null || identical(uid, this.uid))) {
      return this;
    }

    return new SessionModel(
      token: token ?? this.token,
      uid: uid ?? this.uid,
    );
  }

  @override
  String toString() {
    return 'SessionModel{token: $token, uid: $uid}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionModel &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          uid == other.uid);

  @override
  int get hashCode => token.hashCode ^ uid.hashCode;

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return new SessionModel(
      token: map['token'] as String,
      uid: map['uid'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'token': this.token,
      'uid': this.uid,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}