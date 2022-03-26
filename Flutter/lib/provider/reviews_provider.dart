import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_g/domain/service/database_api.dart';
import 'package:team_g/models/review_model.dart';

class ReviewsProvider extends ChangeNotifier {
  // final _tweetsSnapshot = <DocumentSnapshot>[];
  final _reviewsSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  bool _hasReviewNext = true;
  bool _isFetchingReviews = false;

  String get errorMessage => _errorMessage;

  bool get hasReviewNext => _hasReviewNext;

  List<Review> get reviews =>
      _reviewsSnapshot.map((snap) => Review.fromDoc(snap)).toList();

  Future fetchNextReviews() async {
    if (_isFetchingReviews) return;

    _errorMessage = '';
    _isFetchingReviews = true;

    try {
      QuerySnapshot snap = await DatabaseServices.getAllTweets(
        startAfter: _reviewsSnapshot.isNotEmpty ? _reviewsSnapshot.last : null,
      );
      _reviewsSnapshot.addAll(snap.docs);

      if (snap.docs.length < 30) _hasReviewNext = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }
    _isFetchingReviews = false;
  }
}
