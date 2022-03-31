import 'package:flutter/material.dart';
import 'package:hilmy/firebase_options_dev.dart';
import 'package:hilmy/flavor.dart';
import 'package:hilmy/my_app.dart';
import 'package:hilmy/providers/auth_provider.dart';
import 'package:hilmy/providers/theme_provider.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'Hilmy',
    options: FirebaseOptionsDev.currentPlatform,
  ); // ajouté

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) async {
  runApp(
    /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
    MultiProvider(
      providers: [
        Provider<Flavor>.value(value: Flavor.dev),
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
        key: const Key('MyApp'),
      ),
    ),
  );
  // });
}
