import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String uid;
  int score;

  UserModel({
    required this.id,
    required this.uid,
    required this.score,
  });

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(id: doc.id, uid: doc['uid'], score: doc['score']);
  }
}
