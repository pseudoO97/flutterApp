import 'package:flutter/material.dart';
import 'package:hilmy/routes.dart';

class IndividualHome extends StatefulWidget {
  const IndividualHome({ Key? key }) : super(key: key);

  @override
  State<IndividualHome> createState() => _IndividualHomeState();
}

class _IndividualHomeState extends State<IndividualHome> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
         Navigator.of(context).popAndPushNamed(Routes.login);
          return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          child: Text('particulier'),
        ),
      ),
    );
  }
}