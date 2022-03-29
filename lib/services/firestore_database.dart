import 'dart:async';

import 'package:hilmy/models/appointment_model.dart';
import 'package:hilmy/models/intervention_model.dart';
import 'package:hilmy/models/service_model.dart';
import 'package:hilmy/models/user_model.dart';
import 'package:hilmy/services/firestore_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hilmy/services/firestore_service.dart';

import '../models/category_model.dart';

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

  //Méthodes pour les utilisateurs
  Stream<UserModel> userStream({required String uid}) =>
      _firestoreService.documentStream(
        path: FirestorePath.user(uid),
        builder: (data, documentId) =>
            UserModel.fromMap(data, documentId),
  );

  Stream<List<UserModel>> usersStream() {
    return _firestoreService.collectionStream(
      path: FirestorePath.users(),
      builder: (data, documentId) =>
          UserModel.fromMap(data, documentId),
    );
  }

  Future<void> updateUserData(
          {required String userId,
          required Map<String, dynamic> data}) async =>
      await _firestoreService.update(
        path: FirestorePath.user(userId),
        data: data,
  );

  // Catégories
  Stream<List<CategoryModel>> categoriesStream() {
    return _firestoreService.collectionStream(
      path: FirestorePath.categories(),
      builder: (data, documentId) =>
          CategoryModel.fromMap(data, documentId),
    );
  }

  // Services
  Stream<List<ServiceModel>> servicesStream({required String? searchKey}) {
    return _firestoreService.collectionStream(
      path: FirestorePath.services(),
      queryBuilder: (query) => query
      .where('name', arrayContains: searchKey),
      builder: (data, documentId) =>
          ServiceModel.fromMap(data, documentId),
    );
  }

   Future<void> addService({
      required String id,
      }) async =>
      await _firestoreService.set(
        path: FirestorePath.service(id),
        data: {'_created_at': Timestamp.now()},
      );
    Future<void> updateService({
        required String attribute,
      required dynamic value,
      required String id,
      }) async =>
      await _firestoreService.update(
        path: FirestorePath.service(id),
        data: {attribute: value},
      );

       Future<void> updateNameService({
        required String firstName,
        required String lastName,
      required String id,
      }) async =>
      await _firestoreService.update(
        path: FirestorePath.service(id),
        data: {'first_name': firstName, 'last_name' : lastName},
      );

  // RDV

  Stream<AppointmentModel> appointmentStream({required String uid}) =>
      _firestoreService.documentStream(
        path: FirestorePath.appointment(uid),
        builder: (data, documentId) =>
            AppointmentModel.fromMap(data, documentId),
      );

  Stream<List<AppointmentModel>> appointmentsStream({
    required String role,
    required String id,
  }) {
    return _firestoreService.collectionStream(
      path: FirestorePath.appointments(),
      builder: (data, documentId) =>
          AppointmentModel.fromMap(data, documentId),
          queryBuilder: (query) => query
          .where(role, isEqualTo: id)
    );
  }

   Future<void> addAppointment({
      required String individual_id,
      required String professionnal_id,
    }) async =>
    await _firestoreService.add(
      path: FirestorePath.appointments(),
      data: {'_created': true, 'individual_id': individual_id, 'professionnal_id': professionnal_id},
    );
}
