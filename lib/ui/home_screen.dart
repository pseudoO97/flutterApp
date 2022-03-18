import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_colors.dart';
import 'package:hilmy/models/person_model.dart';
import 'package:hilmy/models/user_model.dart';
import 'package:hilmy/providers/auth_provider.dart';
import 'package:hilmy/routes.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:hilmy/ui/individual/individual_home.dart';
import 'package:hilmy/ui/professional/professional_home.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    
   final firestoreDatabase =  Provider.of<FirestoreDatabase>(context, listen: false);
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).snapshots(),
          builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text('Loading...'));
              }
              final DocumentSnapshot<Object?> user =
                  snapshot.requireData;
                  return MaterialApp(
                    home: user['type'] == 'professional' ? const Professionalhome() :  const IndividualHome(),
                  );
          });
  }
}