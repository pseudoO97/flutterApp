import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_styles.dart';
import 'package:hilmy/models/category_model.dart';
import 'package:hilmy/models/service_model.dart';
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
  String name = '';
  @override
  Widget build(BuildContext context) {
  final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
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
            icon: const Icon(Icons.login, color: Colors.black,) , 
            onPressed: () => {
                FirebaseAuth.instance.signOut(),  
                Navigator.of(context).pushReplacementNamed(Routes.login)
              },
            ),
          ],
        ), 
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (value) => {
                  setState(() {
                    name = value;
                  }),
                },
              ),
              const SizedBox(height: 18),
              name == '' ? 
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
                              return GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber.shade200
                                   ),
                                  child: Center(child: Text(categories[index].name ?? ''))
                                ),
                              );
                            }, 
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 100,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                crossAxisCount: 2,
                                childAspectRatio: 2,
                              ),
                          );
                        }
                    }
                    if (!snapshot.hasData) {
                      print(snapshot.error);
                    }
                  return const Text('pas de données');
                }
              ) :
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('services').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Text('Loading...'));
                  }
                  if (!snapshot.hasData) {
                    return const Text('Pas de résultats');
                  }
                  return SizedBox(
                    width: 550.0,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: snapshot.requireData.docs
                            .where((service) => service['name'].contains(name))
                            .map((DocumentSnapshot<Object?> service) {
                          return Text(service['name']);
                        }).toList(), // Très important sinon les types ne sont pas compatibles
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}