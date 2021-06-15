import 'dart:ui';

import 'package:factoryapp/domain/model/factory_model.dart';
import 'package:factoryapp/domain/repository/api_repository.dart';
import 'package:factoryapp/domain/repository/local_storage_repository.dart';
import 'package:factoryapp/presentation/home/home_add_dialog.dart';
import 'package:factoryapp/presentation/home/home_bloc.dart';
import 'package:factoryapp/presentation/home/home_detail_screen.dart';
import 'package:factoryapp/presentation/home/item_factory.dart';
import 'package:factoryapp/presentation/splash/splash_screen.dart';
import 'package:factoryapp/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen._();

  static Widget init(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => HomeBLoC(
              apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
              localRepositoryInterface:
                  context.read<LocalRepositoryInterface>())
            // ..loadFactories()
            ..loadUser(),
          builder: (_, __) => HomeScreen._()),
    ]);
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String name = '', location = '';
  double employes = 0, rate = 0;
  final _formKey = GlobalKey<FormState>();
  double sigmaX = 0;
  double sigmaY = 0;
  late AnimationController _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  Future<void> logOut(BuildContext context) async {
    final profileBloc = Provider.of<HomeBLoC>(context, listen: false);
    await profileBloc.logOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => SplashScreen.init(context)),
        (route) => false);
  }

  void addFactor() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final factor = Factory(
          name: name, location: location, rate: rate, employees: employes);

      final provider = Provider.of<HomeBLoC>(context, listen: false);
      provider.addFactory(factor);
    }
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _duration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeBLoC homeBloc = Provider.of<HomeBLoC>(context);
    homeBloc.loadFactories();
    final user = homeBloc.user;

    return Scaffold(
      backgroundColor: FactoryColors.veryLightGrey,
      appBar: AppBar(
        backgroundColor: FactoryColors.purpleBerry,
        leading: user?.image == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 15),
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
          ? GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(35),
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
                      }),
                ),
                SlideTransition(
                  position: _tween.animate(_controller),
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.1,
                    minChildSize: 0.1,
                    maxChildSize: 0.6,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: BackdropFilter(
                          filter: new ImageFilter.blur(
                              sigmaX: sigmaX, sigmaY: sigmaY),
                          child: Container(
                            decoration: BoxDecoration(
                                color: FactoryColors.purpleBerry.withOpacity(
                                    0.9)), //Colors.grey.shade400.withOpacity(0.5)),
                            child: Column(
                              children: [
                                Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200
                                          .withOpacity(0.5)),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('  Add Factory',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.lato(
                                                    color: FactoryColors.white,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 22,
                                                  )),
                                              const SizedBox(height: 8),
                                              FactoryFormWidget(
                                                  onChangedName: (name) => setState(
                                                      () => this.name = name),
                                                  onChangedLocation:
                                                      (location) => setState(
                                                          () => this.location =
                                                              location),
                                                  onChangedEmployes:
                                                      (employes) => setState(
                                                          () => this.employes =
                                                              double.parse(
                                                                  employes)),
                                                  onChangedrate: (rates) =>
                                                      setState(() => this.rate = double.parse(rates)),
                                                  onSavedFactor: () {
                                                    addFactor();
                                                  }),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            )
          : Center(child: const CircularProgressIndicator()),
      floatingActionButton: GestureDetector(
        child: FloatingActionButton(
          mini: true,
          child: AnimatedIcon(
              icon: AnimatedIcons.menu_close, progress: _controller),
          elevation: 5,
          backgroundColor: FactoryColors.orange,
          foregroundColor: FactoryColors.white,
          onPressed: () async {
            if (_controller.isDismissed) {
              sigmaX = 10;
              sigmaY = 10;
              _controller.forward();
            } else if (_controller.isCompleted) {
              _controller.reverse();
              sigmaX = 0;
              sigmaY = 0;
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }
}
