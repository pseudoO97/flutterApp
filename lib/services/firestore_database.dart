import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hilmy/models/intervention_model.dart';
import 'package:hilmy/models/task_model.dart';
import 'package:hilmy/services/firestore_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hilmy/services/firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

/*
This is the main class access/call for any UI widgets that require to perform
any CRUD activities operation in FirebaseFirestore database.
This class work hand-in-hand with FirestoreService and FirestorePath.

Notes:
For cases where you need to have a special method such as bulk update specifically
on a field, then is ok to use custom code and write it here. For example,
setAllTodoComplete is require to change all todos item to have the complete status
changed to true.

 */
class FirestoreDatabase {
  FirestoreDatabase({required this.uid}) : assert(uid != null);
  final String uid;

  final _firestoreService = FirestoreService.instance;

  //Méthodes pour la collection des interventions
  Stream<InterventionModel> interventionStream({required String uid}) =>
      _firestoreService.documentStream(
        path: FirestorePath.intervention(uid),
        builder: (data, documentId) =>
            InterventionModel.fromMap(data, documentId),
      );

  Stream<List<InterventionModel>> interventionsStream() {
    return _firestoreService.collectionStream(
      path: FirestorePath.interventions(),
      queryBuilder: (query) => query.where('user_email',
          isEqualTo: FirebaseAuth.instance.currentUser == null
              ? false
              : FirebaseAuth.instance.currentUser!.email),
      builder: (data, documentId) =>
          InterventionModel.fromMap(data, documentId),
    );
  }

  Future<void> updateData(
          {required String interventionId,
          required Map<String, dynamic> data}) async =>
      await _firestoreService.update(
        path: FirestorePath.intervention(interventionId),
        data: data,
      );
}
