import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilmy/models/appointment_model.dart';
import 'package:hilmy/services/firestore_database.dart';
import 'package:provider/provider.dart';

class AppointmentHistory extends StatefulWidget {
  const AppointmentHistory({ Key? key }) : super(key: key);

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  @override
  Widget build(BuildContext context) {
    final firestoreDatabase =  Provider.of<FirestoreDatabase>(context, listen: false);
    final _auth = FirebaseAuth.instance;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Vos rendez-vous'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Text('A venir')),
              Tab(icon: Text('Passés')),
            ],
          ),
        ),
        body: StreamBuilder(
          stream: firestoreDatabase.appointmentsStream(role: 'individual_id', id: _auth.currentUser!.uid),
          builder: (context, snapshot) {
             if (snapshot.hasData) {
              List<AppointmentModel> appointments =
                  snapshot.data as List<AppointmentModel>;
              if (appointments.isNotEmpty) {
                return TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: appointments.length,
                            separatorBuilder: (context, index) {
                              return const Divider(height: 0.5);
                            },
                            itemBuilder: (context, index) {
                              return Text(appointments[index].individualId ?? '');
                            }
                        ),
                      ),
                      SingleChildScrollView(
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: appointments.length,
                            separatorBuilder: (context, index) {
                              return const Divider(height: 0.5);
                            },
                            itemBuilder: (context, index) {
                              return Text(appointments[index].professionnalName ?? '');
                            }
                        ),
                      ),
                    ],
                  );
                }
             }
             else if(snapshot.hasError) {
               print(snapshot.error);
             }
             return Text('Pas de rendez-vous');
          }
        ),
      ),
    );
  }
}