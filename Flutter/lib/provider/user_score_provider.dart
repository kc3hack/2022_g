import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_g/domain/service/database_api.dart';
import 'package:team_g/models/review_model.dart';
import 'package:team_g/models/user_model.dart';

class UserScoresProvider extends ChangeNotifier {
  // final _tweetsSnapshot = <DocumentSnapshot>[];
  final _scoreSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  int get usersNum => _scoreSnapshot.length;

  List<UserModel> get users =>
      _scoreSnapshot.map((snap) => UserModel.fromDoc(snap)).toList();

  Future fetchNextScores() async {
    try {
      QuerySnapshot snap = await DatabaseServices.getUserScoreRanking();
      _scoreSnapshot.addAll(snap.docs);
      print("---------------------snapshot---------------${_scoreSnapshot}");
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
  }
}
