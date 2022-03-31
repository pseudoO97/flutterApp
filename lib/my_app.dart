import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/auth_widget_builder.dart';
import 'package:hilmy/flavor.dart';
import 'package:hilmy/models/user_model.dart';
import 'package:hilmy/providers/auth_provider.dart';
import 'package:hilmy/providers/theme_provider.dart';
import 'package:hilmy/routes.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:hilmy/ui/auth/sign_in_screen.dart';
import 'package:hilmy/ui/home/home.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.databaseBuilder}) : super(key: key);
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState(){
  //   super.initState();
  //   _checkVersion();
  // }

  // void _checkVersion() {
  //   final newVersion = NewVersion(
  //     androidId: 'com.mds.digital_project',
  //     iOSId: 'com.mds.digital_project',
  //     );
  //     newVersion.showAlertIfNecessary(context: context);
  // }
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProviderRef, __) {
        return AuthWidgetBuilder(
          databaseBuilder: widget.databaseBuilder,
          builder:
              (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Hilmi',
              routes: Routes.routes,
              themeMode: themeProviderRef.isDarkModeOn
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: userSnapshot.connectionState == ConnectionState.active &&
                      FirebaseAuth.instance.currentUser != null
                  ? HomeScreen()
                  : SignInScreen(),
            );
          },
          key: Key('AuthWidget'),
        );
      },
    );
  }
}
