import 'package:cloud_firestore/cloud_firestore.dart';

/*
This class represent all possible CRUD operation for FirebaseFirestore.
It contains all generic implementation needed based on the provided document
path and documentID,since most of the time in FirebaseFirestore design, we will have
documentID and path for any document and collections.
 */
class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<DocumentSnapshot?> get({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    return reference.get();
  }

    Future<Future<QuerySnapshot<Map<String, dynamic>>>> getCollection<T>({required String path}) async {
    final reference = FirebaseFirestore.instance.collection(path);
    return reference.get();
  }

  Future<void> set({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // print('$path: $data');
    await reference.set(data);
  }

  //  Future<String?> get({
  //   required String path,
  //   bool merge = false,
  // }) async {
  //   final reference = FirebaseFirestore.instance.doc(path);
  //   print('$path: ');
  //   await reference.get();
  // }

  Future<void> bulkSet({
    required String path,
    required List<Map<String, dynamic>> datas,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    final batchSet = FirebaseFirestore.instance.batch();

//    for()
//    batchSet.

    // print('$path: $datas');
  }

  // Mettre à jour un champ d'une collection
  Future<void> update(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // print('update: $path');
    await reference.update(data);
  }

  Future<void> add(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.collection(path);
    print('add: $path');
    await reference.add(data);
  }

  Future<void> deleteData({required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // print('delete: $path');
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
    Query queryBuilder(Query query)?,
    int sort(T lhs, T rhs)?,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }

  Query query({required String path}) =>
      FirebaseFirestore.instance.collection(path);
}
