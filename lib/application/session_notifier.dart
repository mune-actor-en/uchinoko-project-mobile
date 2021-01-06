import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:uchinoko_project_mobile/infrastructure/model/user_model.dart';
import 'package:uchinoko_project_mobile/infrastructure/repository/session_repository.dart';

abstract class SessionState{
  const SessionState();
}

class SessionJudge extends SessionState {
  const SessionJudge();
}

class SessionTrying extends SessionState {
  const SessionTrying();
}

class SessionComplete extends SessionState {
  const SessionComplete({this.session});
  final SessionModel session;
}

class SessionError extends SessionState {
  const SessionError({this.errorMessage = "ログインに失敗しました"});
  final String errorMessage;
}

class SessionNotifier extends StateNotifier<SessionState> {
  SessionNotifier({this.sessionRepository}) : super(SessionJudge());
  final SessionRepository sessionRepository;

  Future<void> login({@required String email, @required String password,}) async {
    try {
      state = SessionTrying();
      final SessionModel session = await sessionRepository.login(
        email: email, password: password
      );
      state = SessionComplete(session: session);
      SessionComplete tmp = state;
      print(tmp.session);
    } on Exception {
      state = SessionError(
        errorMessage: "メールアドレスもしくはパスワードが正しくありません"
      );
    }
  }

  void logout() {
    try {
      state = SessionJudge();
    } on Exception {
      state = SessionError(
          errorMessage: "ログアウトできませんでした"
      );
    }
  }
}