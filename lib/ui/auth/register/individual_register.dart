import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hilmy/constants/app_styles.dart';
import 'package:hilmy/models/user_model.dart';
import 'package:hilmy/providers/auth_provider.dart';
import 'package:hilmy/routes.dart';
import 'package:hilmy/ui/widgets/form/dropdown_input.dart';
import 'package:provider/provider.dart';

class IndividualRegister extends StatefulWidget {
  @override
  _IndividualRegisterState createState() => _IndividualRegisterState();
}

class _IndividualRegisterState extends State<IndividualRegister> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _pseudoController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _pseudoController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kLightDark,
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

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12, //spread radius
                    blurRadius: 10,
                    offset: Offset(1, 1),
                  )
                ],
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: textSection),
                  ),
                  
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12, //spread radius
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 60,
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.people_outline,
                            size: 30,
                            color: kLightGreen,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 230,
                          child: Center(
                            child: TextFormField(
                              controller: _emailController,
                              validator: (value) => value!.isEmpty
                                  ?  "Veuillez renseigner un email valide"
                                  : null,
                              textAlign: TextAlign.left,
                              obscureText: false,
                              decoration: const InputDecoration(
                                hintText: 'Adresse email',
                                border: InputBorder.none,
                              ),
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    // mot de passe
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12, //spread radius
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 60,
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.lock_outline,
                            size: 30,
                            color: kLightGreen,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 230,
                          child: Center(
                            child: TextFormField(
                              controller: _passwordController,
                              validator: (value) => value!.length < 6
                                  ? "Votre mot de passe est trop court, il faut minimum 6 caractères"
                                  : null,
                              textAlign: TextAlign.left,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Mot de passe',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  authProvider.status == Status.Registering
                      ? const Center(
                          child: const CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kLightGreen,
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          child: Text(
                            "S'inscrire".toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context)
                                  .unfocus(); //to hide the keyboard - if any

                              UserModel userModel = await authProvider
                                  .registerWithEmailAndPassword(
                                      _emailController.text,
                                      _passwordController.text);

                              if (userModel.uid == 'weak-password') {
                                showDialog(
                                  context: context,
                                  builder: (context) => errorMessage(
                                      'Votre mot de passe doit faire minimum 6 caractères'),
                                );
                              } else if (userModel.uid ==
                                  'email-already-in-use') {
                                showDialog(
                                  context: context,
                                  builder: (context) => errorMessage(
                                      'Cet email est déjà utilisé'),
                                );
                              } else if (userModel.uid == 'invalid-email') {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      errorMessage('L\'e-mail est invalide'),
                                );
                              } else if (userModel.uid == 'unknown') {
                                showDialog(
                                  context: context,
                                  builder: (context) => errorMessage(
                                      'Remplissez tous les champs'),
                                );
                              } else {
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
                                      .pushReplacementNamed(Routes.home);
                                }
                              }

                              // print(userModel);

                              // if (userModel == null) {
                              //   _scaffoldKey.currentState!
                              //       .showSnackBar(SnackBar(
                              //     content: Text("loginTxtErrorSignIn"),
                              //   ));
                              // }
                            }
                          }),
                  // : RaisedButton(
                  //     child: Text(
                  //       "loginBtnSignUp",
                  //       style: Theme.of(context).textTheme.button,
                  //     ),
                  //     onPressed: () async {
                  //       if (_formKey.currentState!.validate()) {
                  //         FocusScope.of(context)
                  //             .unfocus(); //to hide the keyboard - if any

                  //         UserModel userModel =
                  //             await authProvider.registerWithEmailAndPassword(
                  //                 _emailController.text,
                  //                 _passwordController.text);

                  //         if (userModel == null) {
                  //           _scaffoldKey.currentState!.showSnackBar(SnackBar(
                  //             content: Text("loginTxtErrorSignIn"),
                  //           ));
                  //         }
                  //       }
                  //     }),
                  authProvider.status == Status.Registering
                      ? const Center(
                          child: null,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 48),
                          child: Center(
                              child: Text(
                            "Vous avez déjà un compte ?",
                            style: Theme.of(context).textTheme.button,
                          )),
                        ),
                  authProvider.status == Status.Registering
                      ? const Center(
                          child: null,
                        )
                      : TextButton(
                          child: const Text("Se connecter"),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.login);
                          },
                        ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget textSection = Container(
    margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
    child: Text(
      'Inscription',
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

Widget errorMessage(String text) => Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/logo-mintizy.png",
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Erreur : " + text)
            ],
          ),
        ),
      ),
    );
