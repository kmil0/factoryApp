import 'package:factoryapp/domain/model/user_model.dart';
import 'package:factoryapp/domain/repository/api_repository.dart';
import 'package:factoryapp/domain/repository/local_storage_repository.dart';
import 'package:flutter/material.dart';

class HomeBLoC extends ChangeNotifier {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;

  HomeBLoC(
      {required this.apiRepositoryInterface,
      required this.localRepositoryInterface});

  User? user;

  void loadUser() async {
    user = await localRepositoryInterface.getUser();
    notifyListeners();
  }
}
