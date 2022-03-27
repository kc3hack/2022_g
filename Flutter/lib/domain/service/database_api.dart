import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_g/constants/constants.dart';
import 'package:team_g/models/review_model.dart';

class DatabaseServices {
  static void createReview(Review review) {
    reviewsRef.add({
      'text': review.text,
      'category': review.category,
      "authorId": review.authorId,
      "timestamp": review.timestamp,
      "prefecture": review.prefecture,
      "city": review.city,
    });
  }

  static Future<QuerySnapshot> getAllReviews(
      {DocumentSnapshot? startAfter}) async {
    final refTweets =
        reviewsRef.orderBy('timestamp', descending: true).limit(30);
    if (startAfter == null) {
      print("----------------------------------null------------------");
      print(refTweets.get());
      return refTweets.get();
    } else {
      return refTweets.startAfterDocument(startAfter).get();
    }
  }

  static Future<List<Review>> getUserReviews(String userId) async {
    QuerySnapshot userReviewSnap =
        await reviewsRef.where('authorId', isEqualTo: userId).get();
    List<Review> userReview =
        userReviewSnap.docs.map((doc) => Review.fromDoc(doc)).toList();
    return userReview;
  }

  static void updateScore(String score) {
    usersRef.doc(currentUserId).update({'score': int.parse(score)});
  }
}
