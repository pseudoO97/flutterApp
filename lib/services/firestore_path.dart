/*
This class defines all the possible read/write locations from the FirebaseFirestore database.
In future, any new path can be added here.
This class work together with FirestoreService and FirestoreDatabase.
 */

class FirestorePath {
  static String intervention(String uid) => 'interventions/$uid';
  static String interventions() => 'interventions';
}
