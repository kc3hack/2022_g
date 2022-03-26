import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String uid;

  UserModel({required this.id, required this.uid});

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      uid: doc['uid'],
    );
  }
}
