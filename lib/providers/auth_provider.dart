import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hilmy/models/user_model.dart';
import 'package:hilmy/services/firestore_database.dart';


enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}
/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, the Splash Screen will be shown
- Authenticated - User is authenticated successfully, Home Page will be shown
- Authenticating - Sign In button just been pressed, progress bar will be shown
- Unauthenticated - User is not authenticated, login page will be shown
- Registering - User just pressed registering, progress bar will be shown

Take note, this is just an idea. You can remove or further add more different
status for your UI or widgets to listen.
 */

class AuthProvider extends ChangeNotifier {
  //Firebase Auth object
  late FirebaseAuth _auth;
  late FirestoreDatabase firestoreDatabase;
  //Default status
  Status _status = Status.Uninitialized;
  String _name = '';
  String _type = '';

  Status get status => _status;

  String get name => _name;
  String get type => _type;

  Stream<UserModel> get user => _auth.authStateChanges().map(_userFromFirebase);

  UserModel? _user;

  UserModel? get userType {
    if (_status == Status.Authenticated) {
      return _user;
    }
  }

  AuthProvider() {
    //initialise object
    _auth = FirebaseAuth.instance;

    //listener for authentication changes such as user sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  //Create user object based on the given User
  UserModel _userFromFirebase(User? user) {
    if (user == null) {
      return UserModel(displayName: 'Null', uid: 'null');
    }

    return UserModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        phoneNumber: user.phoneNumber,
    );
  }

  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  //Method for new user registration using email and password
  Future<UserModel> registerWithEmailAndPassword(
      String email, 
      String password, 
      String type, 
      String? category, 
      String firstName, 
      String lastName, 
      String address, 
      String birthday,
      String sexe,
      ) async {
    try {
      _status = Status.Registering;
      notifyListeners();
      _name = firstName;
      _type = type;
      notifyListeners();
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
  
    FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).set({ 
      'email': email,
      'type': type,
      'category': category ?? '',
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
      'birthday': birthday,
    });

    //getUser(_auth.currentUser!.uid, email, firstName);
      return _userFromFirebase(result.user);
    } on FirebaseAuthException catch (e) {
      print("Error on the new user registration = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return UserModel(displayName: 'Null', uid: 'null');
    }
  }

  //Method to handle user sign in using email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //  getUser(String uid, String email, String firstName){
  //       return UserModel(uid: uid, email: email, firstName: firstName);
  //     }

  //Method to handle password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Method to handle user signing out
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
