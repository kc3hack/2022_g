import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String? id;
  String? authorId;
  String? text;
  String? category;
  // String? image;
  Timestamp? timestamp;
  String? prefecture;
  String? city;

  factory Review.fromDoc(DocumentSnapshot doc) {
    return Review(
      id: doc.id,
      authorId: doc['authorId'],
      text: doc['text'],
      category: doc['category'],
      timestamp: doc['timestamp'],
      prefecture: doc['prefecture'],
      city: doc['city'],
    );
  }

  Review({
    this.id,
    this.authorId,
    this.text,
    this.category,
    this.prefecture,
    this.timestamp,
    this.city,
  });
}
