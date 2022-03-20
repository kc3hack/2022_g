import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  late User _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final _fireStore = FirebaseFirestore.instance;

  AuthModel() {
    final User? _currentUser = _auth.currentUser;

    if (_currentUser != null) {
      _user = _currentUser;
      notifyListeners();
    }
  }

  User get user => _user;
  bool get loggedIn => _user != null;

  Future<String> signInAnonymous() async {
    var error = '';
    if (FirebaseAuth.instance.currentUser == null) {
      try {
        await FirebaseAuth.instance.signInAnonymously().then((task) async => {
              print('uid: ${task.user!.uid}'),
              await createUserData(task.user!.uid)
            });
      } on FirebaseAuthException catch (e) {
        print(e.toString());
        error = e.toString();
      }
    }
    print('current User : ${FirebaseAuth.instance.currentUser!.uid}');
    notifyListeners();
    return error;
  }

  // ユーザーデータ -----
  Future<void> createUserData(String uid) async {
    final data = <String, dynamic>{
      'name': '',
      'profilePicture': '',
      'bio': '',
      'uid': uid.substring(1, 11)
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(
          data,
        )
        .catchError(
          (Object error) => print('Failed to set data: ${error.toString()}'),
        );
  }

  bool isAnonymousLogin() {
    return FirebaseAuth.instance.currentUser!.isAnonymous;
  }

  Future<void> registration(String email, String pass) async {
    try {
      final authCredential =
          EmailAuthProvider.credential(email: email, password: pass);

      final userCredential = await FirebaseAuth.instance.currentUser!
          .linkWithCredential(authCredential);

      print(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  // Future login(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     _user = result.user;
  //     notifyListeners();
  //     return FirebaseAuthResultStatus.Successful;
  //   } catch (e) {
  //     notifyListeners();
  //     return FirebaseAuthExceptionHandler.handleException(e);
  //   }
  // }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
