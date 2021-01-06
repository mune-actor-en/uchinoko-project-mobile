import 'package:uchinoko_project_mobile/infrastructure/model/user_model.dart';
import 'package:uchinoko_project_mobile/infrastructure/service/fetch_api.dart';

class SessionRepository {
  const SessionRepository({this.httpService});

  final HttpService httpService;

  Future<SessionModel> login({String email, String password}) async {
    try {
      final extractedData = await httpService.login(
        email: email,
        password: password,
      );
      return SessionModel.fromMap(extractedData);
    } catch (error) {
      return Future.error(error);
    }
  }
}
