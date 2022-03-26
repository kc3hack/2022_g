import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Palette {
  static const Color KTweeterColor = Color(0xff00acee);
  static const Color red = Color.fromRGBO(221, 17, 17, 1);
  static const Color yellow = Color.fromRGBO(255, 219, 0, 1);
  static const Color darkBlue = Color(0xff092E34);
  static const Color lightBlue = Color(0xff489FB5);
  static const Color orange = Color(0xffFFA62B);
  static const Color darkOrange = Color(0xffCC7700);
  static const Color linkone = Color(0xFF33CCFF);
  static const Color white = Color(0xFAFAFAFA);
  static const Color linen = Color.fromRGBO(255, 229, 217, 1);
  static const Color lightgray = Color.fromRGBO(206, 206, 206, 1);
}

final _fireStore = FirebaseFirestore.instance;
final _fireAuth = FirebaseAuth.instance;

final usersRef = _fireStore.collection('users');

final reviewsRef = _fireStore.collection('reviews');

final currentUserId = _fireAuth.currentUser!.uid.toString();

final currentUser = _fireAuth.currentUser;
