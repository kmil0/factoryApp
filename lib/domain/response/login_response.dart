import 'package:factoryapp/domain/model/user_model.dart';

class LoginResponse {
  final String token;
  final User user;

  LoginResponse(this.token, this.user);
}
