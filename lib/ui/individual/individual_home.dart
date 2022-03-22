import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/models/category_model.dart';
import 'package:hilmy/routes.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:provider/provider.dart';

class IndividualHome extends StatefulWidget {
  final String firstName;
  const IndividualHome({ Key? key, required this.firstName }) : super(key: key);

  @override
  State<IndividualHome> createState() => _IndividualHomeState();
}

class _IndividualHomeState extends State<IndividualHome> {
  @override
  Widget build(BuildContext context) {
  final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
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
        children: <Widget>[
          const Center(
            child: Text('Que recherchez-vous ?'),
          ),
          StreamBuilder(
            stream: firestoreDatabase.categoriesStream(),
            builder:  (context, snapshot) {
                if (snapshot.hasData) {
                  List<CategoryModel> categories = snapshot.data as List<CategoryModel>;
                    if (categories.isNotEmpty) {
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          print(categories[index].name);
                          return GestureDetector(
                            child: Text(categories[index].name ?? ''),
                          );
                        }, 
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 100,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            crossAxisCount: 3,
                            childAspectRatio: 2,
                          ),
                      );
                    }
                }
                if (!snapshot.hasData) {
                  print(snapshot.error);
                }
              return Text('pas de données');
            }
          ),
        ],
      ),
    );
  }
}