import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_styles.dart';
import 'package:hilmy/routes.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:provider/provider.dart';

class Professionalhome extends StatefulWidget {
  final String? firstName;
  const Professionalhome({ Key? key, this.firstName }) : super(key: key);

  @override
  State<Professionalhome> createState() => _ProfessionalhomeState();
}

class _ProfessionalhomeState extends State<Professionalhome> {
  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =  Provider.of<FirestoreDatabase>(context, listen: false);
   final _auth = FirebaseAuth.instance;
    String? firstName = widget.firstName;
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
          children: <Widget>[
            Center(
              child: TextButton(
                 child: const Text('Mettez en ligne votre premier service !'),
                onPressed: () => {
                  Navigator.of(context).popAndPushNamed(Routes.formAddService),
                  firestoreDatabase.addService(
                      id: _auth.currentUser!.uid
                    ),
                  },
                ),
            )
          ],
        ),
      ),
    );
  }
}