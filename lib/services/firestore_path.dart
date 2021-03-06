/*
This class defines all the possible read/write locations from the FirebaseFirestore database.
In future, any new path can be added here.
This class work together with FirestoreService and FirestoreDatabase.
 */

class FirestorePath {
  static String user(String uid) => 'users/$uid';
  static String users() => 'users';
  static String category(String uid) => 'categories/$uid';
  static String categories() => 'categories';
  static String service(String uid) => 'services/$uid';
  static String services() => 'services';
  static String appointment(String uid) => 'appointments/$uid';
  static String appointments() => 'appointments';
}
