import 'package:factoryapp/domain/model/factory_model.dart';
import 'package:factoryapp/domain/repository/api_repository.dart';
import 'package:factoryapp/domain/repository/local_storage_repository.dart';
import 'package:factoryapp/presentation/home/home_bloc.dart';
import 'package:factoryapp/presentation/home/home_detail_screen.dart';
import 'package:factoryapp/presentation/splash/splash_screen.dart';
import 'package:factoryapp/presentation/theme.dart';
import 'package:factoryapp/presentation/widgets/factory_button.dart';
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
    homeBloc.loadFactories();
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
        body: homeBloc.factoryList.isNotEmpty
            ? GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: homeBloc.factoryList.length,
                itemBuilder: (context, index) {
                  final factory = homeBloc.factoryList[index];
                  return ItemFactory(
                      textButton: 'Details',
                      factory: factory,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => FactoryDetail(
                                  textButton: 'Back',
                                  factorySelected: factory,
                                )));
                      });
                })
            : Center(child: const CircularProgressIndicator()));
  }
}

class ItemFactory extends StatelessWidget {
  final Factory factory;
  final VoidCallback onTap;
  final String textButton;
  const ItemFactory(
      {Key? key,
      required this.factory,
      required this.onTap,
      required this.textButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Theme.of(context).canvasColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  factory.rate.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Theme.of(context).accentColor),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
                  child: Icon(
                    Icons.star_rounded,
                    color: Theme.of(context).accentColor,
                  ),
                )
              ],
            ),
            Expanded(
                child: CircleAvatar(
                    backgroundColor: FactoryColors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ))),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(factory.name),
                  const SizedBox(height: 5),
                  Text(
                    factory.location,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Theme.of(context).accentColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text('Employess: ${factory.employees.toInt()}'),
                ],
              ),
            ),
            FactoryPurpleButton(
              text: textButton,
              onTap: onTap,
              padding: const EdgeInsets.symmetric(vertical: 4),
              spread: 5,
            )
          ],
        ),
      ),
    );
  }
}
