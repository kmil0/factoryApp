import 'package:factoryapp/data/in_memory_factories.dart';
import 'package:factoryapp/domain/exception/auth_exception.dart';
import 'package:factoryapp/domain/model/factory_model.dart';

import 'package:factoryapp/domain/model/user_model.dart';
import 'package:factoryapp/domain/repository/api_repository.dart';
import 'package:factoryapp/domain/request/login_request.dart';
import 'package:factoryapp/domain/response/login_response.dart';

class ApiRepositoyImpl extends ApiRepositoryInterface {
  @override
  Future<User> getUserFromToken(String token) async {
    await Future.delayed(const Duration(seconds: 1));

    if (token == 'XYZR1') {
      return User(
          name: 'Steve Jobs',
          username: 'stevejobs',
          image: 'assets/images/steve.jpg');
    } else if (token == 'XYZR2') {
      return User(
          name: 'Elon Musk',
          username: 'elonmusk',
          image: 'assets/images/elon.jpg');
    }
    throw AuthException();
  }

  @override
  Future<LoginResponse> login(LoginRequest login) async {
    await Future.delayed(const Duration(seconds: 1));
    if (login.username == 'steve' && login.password == 'jobs') {
      return LoginResponse(
          'XYZR1',
          User(
              name: 'Steve Jobs',
              username: 'stevejobs',
              image: 'assets/images/steve.jpeg'));
    } else if (login.username == 'elon' && login.password == 'musk') {
      return LoginResponse(
          'XYZR2',
          User(
              name: 'Elon Musk',
              username: 'elonmusk',
              image: 'assets/images/elon.jpeg'));
    }
    throw AuthException();
  }

  @override
  Future<void> logout(String token) async {
    print('removin token from sever : $token');
    return;
  }

  @override
  Future<List<Factory>> getFactories() async {
    await Future.delayed(const Duration(seconds: 1));
    return factories;
  }
}
