import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hilmy/flavor.dart';
import 'package:hilmy/my_app.dart';
import 'package:hilmy/firebase_options_prod.dart';
import 'package:hilmy/providers/auth_provider.dart';
import 'package:hilmy/providers/theme_provider.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptionsProd.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(
      /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
      MultiProvider(
        providers: [
          Provider<Flavor>.value(value: Flavor.prod),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          // ChangeNotifierProvider<LanguageProvider>(
          //   create: (context) => LanguageProvider(),
          // ),
          // ChangeNotifierProvider<InterventionProvider>(
          //   create: (context) => InterventionProvider(),
          // ),
        ],
        child: MyApp(
          databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
          key: Key('SimpleFinance'),
        ),
      ),
    );
  });
}
