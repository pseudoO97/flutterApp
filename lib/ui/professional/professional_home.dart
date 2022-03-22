import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/routes.dart';

class Professionalhome extends StatefulWidget {
  final String firstName;
  const Professionalhome({ Key? key, required this.firstName }) : super(key: key);

  @override
  State<Professionalhome> createState() => _ProfessionalhomeState();
}

class _ProfessionalhomeState extends State<Professionalhome> {
  @override
  Widget build(BuildContext context) {
    String firstName = widget.firstName;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Bienvenue $firstName !'),
            IconButton(
            icon: const Icon(Icons.login) , 
            onPressed: () => {
                FirebaseAuth.instance.signOut(),  
                Navigator.of(context).pushReplacementNamed(Routes.login)
              },
            ),
          ],
        ), 
      ),
      body: Column(
        children: const <Widget>[
          Center(
            child: Text('Mettez en ligne votre premier service !'),
          )
        ],
      ),
    );
  }
}