import 'package:factoryapp/domain/model/user_model.dart';

abstract class LocalRepositoryInterface {
  Future<String?> getToken();

  Future<void> clearAllData();

  Future<User> saveUser(User user);

  Future<User> getUser();

  Future<String> saveToken(String token);
}
