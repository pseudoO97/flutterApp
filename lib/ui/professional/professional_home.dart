import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_styles.dart';
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bienvenue $firstName !', style: heading1),
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: const <Widget>[
            Center(
              child: Text('Mettez en ligne votre premier service !'),
            )
          ],
        ),
      ),
    );
  }
}