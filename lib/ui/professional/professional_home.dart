import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/routes.dart';

class Professionalhome extends StatefulWidget {
  const Professionalhome({ Key? key }) : super(key: key);

  @override
  State<Professionalhome> createState() => _ProfessionalhomeState();
}

class _ProfessionalhomeState extends State<Professionalhome> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: const <Widget>[
          Center(
            child: Text('Mettez en ligne votre premier service !'),
          )
        ],
      );
  }
}