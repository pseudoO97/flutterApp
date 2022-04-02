// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_colors.dart';
import 'package:hilmy/constants/app_styles.dart';
import 'package:hilmy/flavor.dart';
import 'package:hilmy/providers/auth_provider.dart';
import 'package:hilmy/routes.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBlue,
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: _buildForm(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _buildForm(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'images/people.png',
                        height: 100,
                        width: 100,
                        color: kViolet,
                      ),
                      const SizedBox(height: 60),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          color: Colors.white,
                          border: Border.all(
                              color: kViolet,
                              width: 4.0,
                              style: BorderStyle.solid),
                        ),
                        height: 60,
                        child: Row(
                          children: [
                            // IconButton(
                            //   icon: const Icon(
                            //     Icons.login,
                            //     color: Colors.black,
                            //   ),
                            //   onPressed: () => {
                            //     Navigator.of(context)
                            //         .pushReplacementNamed(Routes.login)
                            //   },
                            // ),
                            Container(
                              height: 10,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white,
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 42,
                                  width: 100,
                                  child: TextFormField(
                                    controller: _emailController,
                                    validator: (value) => value!.isEmpty
                                        ? "Veuillez renseigner un email"
                                        : null,
                                    textAlign: TextAlign.center,
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      hintText: 'Identifiant',
                                      hintStyle: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold),
                                      border: InputBorder.none,
                                    ),
                                    // maxLength: 15,
                                    cursorWidth: 4,
                                    cursorColor: kViolet,
                                    cursorRadius: const Radius.circular(4),
                                    autocorrect: false,
                                    cursorHeight: 20,

                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ////////
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          color: Colors.white,
                          border: Border.all(
                              color: kViolet,
                              width: 4.0,
                              style: BorderStyle.solid),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 240,
                              child: Center(
                                child: TextFormField(
                                  controller: _passwordController,
                                  validator: (value) => value!.length < 6
                                      ? "Vos identifiants sont incorrects"
                                      : null,
                                  textAlign: TextAlign.center,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'Mot de passe',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),
                                    border: InputBorder.none,
                                  ),
                                  cursorWidth: 4,
                                  cursorColor: kViolet,
                                  cursorHeight: 20,
                                  cursorRadius: const Radius.circular(4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      authProvider.status == Status.Authenticating
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: kViolet,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          "Se connecter",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          FocusScope.of(context)
                                              .unfocus(); //to hide the keyboard - if any

                                          bool status = await authProvider
                                              .signInWithEmailAndPassword(
                                                  _emailController.text,
                                                  _passwordController.text);

                                          if (!status) {
                                            _scaffoldKey.currentState!
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "L'adresse email ou le mot de passe est incorrect."),
                                            ));
                                          } else {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    Routes.home);
                                          }
                                        }
                                      }),
                                ),
                              ],
                            ),
                      authProvider.status == Status.Authenticating
                          ? const Center(
                              child: null,
                            )
                          : const Padding(
                              padding: EdgeInsets.only(top: 48),
                              child: Center(
                                  child: Text("Pas encore de compte ?",
                                      style: TextStyle(
                                          color: kViolet,
                                          fontFamily: 'Roboto-Black'))),
                            ),
                      authProvider.status == Status.Authenticating
                          ? const Center(
                              child: null,
                            )
                          : TextButton(
                              child: const Text(
                                "Inscrivez-vous",
                                style: TextStyle(
                                    color: kViolet, fontFamily: 'Roboto-Black'),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(Routes.bridge);
                              },
                            ),
                      // Center(
                      //     child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: <Widget>[
                      //     SizedBox(
                      //       height: 70,
                      //     ),
                      //     Text(
                      //       Provider.of<Flavor>(context).toString(),
                      //       // style: Theme.of(context).textTheme.body2,
                      //     ),
                      //   ],
                      // )),
                    ],
                  ),
                ),
              ));
        });
  }

  Widget textSection = Container(
    margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
    child: Text(
      'Connexion',
      style: heading2,
    ),
  );
}

class SignInCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);

    var firstEndPoint = Offset(size.width / 2, size.height - 95);
    var firstControlPoint = Offset(size.width / 6, size.height * 0.45);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height / 2 - 50);
    var secondControlPoint = Offset(size.width, size.height + 15);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
