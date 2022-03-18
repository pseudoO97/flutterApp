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
    return WillPopScope(
      onWillPop: () async {
        // await showDialog or Show add banners or whatever
        // return true if the route to be popped
         return true; // return false if you want to disable device back button click
       },
      child: Scaffold(
        appBar: AppBar(title: IconButton(icon: Icon(Icons.login) , onPressed: () => {FirebaseAuth.instance.signOut(),  Navigator.of(context).pushReplacementNamed(Routes.login)},) ),
       body: Container(
          child: Text('professionnel'),
        ),
      ),
    );
  }
}