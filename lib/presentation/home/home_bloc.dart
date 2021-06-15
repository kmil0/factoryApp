import 'package:factoryapp/domain/model/factory_model.dart';
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

  Future<void> logOut() async {
    final token = await localRepositoryInterface.getToken();
    await apiRepositoryInterface.logout(token!);
    await localRepositoryInterface.clearAllData();
  }

  List<Factory> factoryList = <Factory>[];
  List<Factory> factoryTotalList = <Factory>[];

  void loadFactories() async {
    final result = await apiRepositoryInterface.getFactories();
    factoryList = result;
    notifyListeners();
  }

  void addFactory(Factory addedfactory) {
    factoryList.add(addedfactory);
    notifyListeners();
  }
}
