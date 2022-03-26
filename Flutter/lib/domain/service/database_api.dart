import 'package:team_g/constants/constants.dart';
import 'package:team_g/models/review_model.dart';

class DatabaseServices {
  static void createReview(Review review) {
    reviewsRef.add({
      'text': review.text,
      'category': review.category,
      // 'image': review.image,
      "authorId": review.authorId,
      "timestamp": review.timestamp,
    });
  }
}
