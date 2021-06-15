import 'package:factoryapp/domain/repository/api_repository.dart';
import 'package:factoryapp/domain/repository/local_storage_repository.dart';
import 'package:factoryapp/presentation/home/home_bloc.dart';
import 'package:factoryapp/presentation/splash/splash_screen.dart';
import 'package:factoryapp/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  Future<void> logOut(BuildContext context) async {
    final profileBloc = Provider.of<HomeBLoC>(context, listen: false);
    await profileBloc.logOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => SplashScreen.init(context)),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = Provider.of<HomeBLoC>(context);
    final user = homeBloc.user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FactoryColors.purpleBerry,
        leading: user?.image == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(
                  radius: 10,
                  backgroundImage: AssetImage(user!.image),
                ),
              ),
        title: user?.name == null
            ? const SizedBox.shrink()
            : Text(
                'Welcome ${user!.name}',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
        actions: [
          IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                logOut(context);
              },
              icon: Icon(Icons.exit_to_app_rounded)),
        ],
      ),
      body: Container(),
    );
  }
}
