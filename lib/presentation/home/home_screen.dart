import 'package:factoryapp/domain/repository/api_repository.dart';
import 'package:factoryapp/domain/repository/local_storage_repository.dart';
import 'package:factoryapp/presentation/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen._();

  static Widget init(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => HomeBLoC(
              apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
              localRepositoryInterface:
                  context.read<LocalRepositoryInterface>())
            ..loadUser(),
          builder: (_, __) => HomeScreen._()),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
