import 'package:factoryapp/domain/repository/api_repository.dart';
import 'package:factoryapp/domain/repository/local_storage_repository.dart';
import 'package:factoryapp/presentation/home/home_screen.dart';
import 'package:factoryapp/presentation/login/login_bloc.dart';
import 'package:factoryapp/presentation/theme.dart';
import 'package:factoryapp/presentation/widgets/factory_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

const logoSize = 45.0;

class LoginScreen extends StatelessWidget {
  LoginScreen._();

  final _scaffolKey = GlobalKey<ScaffoldState>();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginBLoC(
            apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
            localRepositoryInterface: context.read<LocalRepositoryInterface>()),
        builder: (_, __) => LoginScreen._());
  }

  void login(BuildContext context) async {
    final bloc = context.read<LoginBLoC>();
    final result = await bloc.login();
    if (result) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen.init(context)));
    } else {
      // _scaffolKey.currentState.showSnackBar(snackbar)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login incorrect')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginBLoC>();

    final _borderLight = OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.transparent, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(15));
    return Scaffold(
        key: _scaffolKey,
        body: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ClipPath(
                          clipper: ClippingClass(),
                          child: Container(
                              height: 135.0,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: factoryGradients))),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 90.0,
                            width: 90.0,
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 100,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 5.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(height: 60),
                          Text('UserName',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: FactoryColors.purple,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          TextField(
                            controller: bloc.usernameTextContoller,
                            decoration: InputDecoration(
                                hintText: 'username',
                                filled: true,
                                border: _borderLight,
                                enabledBorder: _borderLight,
                                focusedBorder: _borderLight,
                                hintStyle: GoogleFonts.poppins(
                                    color: FactoryColors.purpleLight,
                                    fontSize: 10),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: FactoryColors.purple,
                                )),
                          ),
                          const SizedBox(height: 20),
                          Text('Password',
                              style: TextStyle(
                                  color: FactoryColors.purple,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          TextField(
                            controller: bloc.passwordTextController,
                            obscureText: true,
                            decoration: InputDecoration(
                              filled: true,
                              border: _borderLight,
                              enabledBorder: _borderLight,
                              hintStyle: GoogleFonts.poppins(
                                  color: FactoryColors.purpleLight,
                                  fontSize: 10),
                              focusedBorder: _borderLight,
                              hintText: 'password',
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              FactoryPurpleButton(
                text: 'Login',
                onTap: () => login(context),
                padding: const EdgeInsets.all(25),
                spread: 20,
              )
            ],
          ),
          Positioned.fill(
              child: (bloc.loginState == LoginState.loading)
                  ? Container(
                      color: Colors.black26,
                      child: Center(
                        child: CircularProgressIndicator(
                            color: FactoryColors.purpleLight),
                      ))
                  : const SizedBox.shrink())
        ]));
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - (size.width / 4),
      size.height,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
