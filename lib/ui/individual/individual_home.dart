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
    return Column(
      children: const <Widget>[
        Center(
          child: Text('Que recherchez-vous ?'),
        )
      ],
    );
  }
}