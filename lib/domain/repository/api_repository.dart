import 'package:factoryapp/domain/model/factory_model.dart';
import 'package:factoryapp/domain/model/user_model.dart';
import 'package:factoryapp/domain/request/login_request.dart';
import 'package:factoryapp/domain/response/login_response.dart';

abstract class ApiRepositoryInterface {
  Future<User> getUserFromToken(String token);

  Future<LoginResponse> login(LoginRequest user);

  Future<void> logout(String token);

  Future<List<Factory>> getFactories();
}
