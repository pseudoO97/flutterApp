import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_colors.dart';
import 'package:hilmy/constants/app_styles.dart';
import 'package:hilmy/models/category_model.dart';
import 'package:hilmy/models/service_model.dart';
import 'package:hilmy/models/user_model.dart';
import 'package:hilmy/providers/auth_provider.dart';
import 'package:hilmy/routes.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:hilmy/ui/widgets/bottom_app.bar.dart';
import 'package:provider/provider.dart';

class IndividualHome extends StatefulWidget {
  final String firstName;
  const IndividualHome({Key? key, required this.firstName}) : super(key: key);

  @override
  State<IndividualHome> createState() => _IndividualHomeState();
}

class _IndividualHomeState extends State<IndividualHome> {
  String category_name = '';
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    var _auth = FirebaseAuth.instance;
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    String firstName = widget.firstName;
    return Scaffold(
      backgroundColor: kLightBlue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bienvenue $firstName ,',
                style: const TextStyle(
                  color: kViolet,
                  fontSize: 30,
                )),
            IconButton(
              icon: const Icon(
                Icons.login,
                color: kViolet,
              ),
              onPressed: () => {},
              iconSize: 40,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  color: Colors.white,
                  border: Border.all(
                      color: kViolet, width: 2.0, style: BorderStyle.solid),
                ),
                child: Row(
                  children: [
                    Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20),
                        //   color: Colors.white,
                        // ),
                        ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: Center(
                          child: TextFormField(
                            onChanged: (value) => {
                              setState(() {
                                category_name = value;
                              }),
                            },
                            decoration: const InputDecoration(
                              hintText: '  Enter a search term',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: kViolet,
                      ),
                      onPressed: () => {},
                      iconSize: 32,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              category_name == ''
                  ? StreamBuilder(
                      stream: firestoreDatabase.categoriesStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<CategoryModel> categories =
                              snapshot.data as List<CategoryModel>;
                          if (categories.isNotEmpty) {
                            return GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                categories[index]
                                                    .path
                                                    .toString(),
                                              ),
                                              fit: BoxFit.fill),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(color: kViolet)),
                                      child: Column(
                                        children: [
                                          Center(
                                              child: Text(
                                                  categories[index].path ??
                                                      '')),
                                        ],
                                      )),
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 100,
                                crossAxisSpacing: 30,
                                mainAxisSpacing: 50,
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
                      })
                  : StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('services')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                  .where((service) => service['category']
                                      .contains(category_name))
                                  .map((DocumentSnapshot<Object?> service) {
                                return Column(
                                  children: [
                                    Text(service['category']),
                                    ElevatedButton(
                                      onPressed: () => {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Container(
                                            height: 60,
                                            width: 60,
                                            child: ElevatedButton(
                                                onPressed: () => {
                                                      firestoreDatabase
                                                          .addAppointment(
                                                        individual_id: _auth
                                                            .currentUser!.uid,
                                                        professionnal_id:
                                                            service.id,
                                                        professionnal_name: service[
                                                            'professionnal_name'],
                                                        name: firstName,
                                                      )
                                                    },
                                                child: const Text(
                                                    'Je prends rendez-vous')),
                                          ),
                                        ),
                                      },
                                      child: const Text('Prendre rendez-vous'),
                                    ),
                                  ],
                                );
                              }).toList(), // Très important sinon les types ne sont pas compatibles
                            ),
                          ),
                        );
                      }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBarWidget(
        type: 'individual_id',
      ),
    );
  }
}
