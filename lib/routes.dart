import 'package:flutter/material.dart';
import 'package:hilmy/ui/auth/bridge.dart';
import 'package:hilmy/ui/auth/register/individual_register.dart';
import 'package:hilmy/ui/auth/register/professional_register.dart';
import 'package:hilmy/ui/auth/sign_in_screen.dart';
import 'package:hilmy/ui/home_screen.dart';
import 'package:hilmy/ui/individual/appointment_history.dart';
import 'package:hilmy/ui/professional/form_add_service.dart';
import 'package:hilmy/ui/splash/splash_screen.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String bridge = '/choice';
  static const String professionalRegister = '/professionalRegister';
  static const String individualRegister = '/individualRegister';
  static const String formAddService = '/formAddService';
  static const String appointmentHistory = '/appointmentHistory';
 
  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => SignInScreen(),
    home: (BuildContext context) => HomeScreen(),
    bridge: (BuildContext context) => Bridge(),
    professionalRegister : (BuildContext context) => ProfessionalRegister(),
    individualRegister: (BuildContext context) => IndividualRegister(),
    formAddService: (BuildContext context) => FormAddService(),
    appointmentHistory: (BuildContext context) => AppointmentHistory(),


  };
}
