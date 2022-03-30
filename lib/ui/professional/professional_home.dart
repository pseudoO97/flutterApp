import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_styles.dart';
import 'package:hilmy/models/user_model.dart';
import 'package:hilmy/providers/auth_provider.dart';
import 'package:hilmy/routes.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:hilmy/ui/widgets/bottom_app.bar.dart';
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
    final authProvider = Provider.of<AuthProvider>(context);
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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(_auth.currentUser?.uid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          } 
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          final DocumentSnapshot<Object?> user = snapshot.requireData;
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: TextButton(
                      child: const Text('Mettez en ligne votre service !'),
                      onPressed: () => {
                        Navigator.of(context).popAndPushNamed(
                          Routes.formAddService,
                          arguments: {
                            'lastName' : user['last_name'], 
                            'firstName': user['first_name']
                          }
                        ),
                        firestoreDatabase.addService(
                            id: _auth.currentUser!.uid
                          ),
                        },
                      ),
                  )
                ],
              ),
            );
        }
      ),
      bottomNavigationBar: const BottomAppBarWidget(type: 'professionnal_id'),
    );
  }
}