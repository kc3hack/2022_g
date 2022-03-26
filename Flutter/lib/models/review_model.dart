import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String? id;
  String? authorId;
  String? text;
  String? category;
  // String? image;
  Timestamp? timestamp;
  // String? location;

  factory Review.fromDoc(DocumentSnapshot doc) {
    return Review(
      id: doc.id,
      authorId: doc['authorId'],
      text: doc['text'],
      category: doc['category'],
      // image: doc['image'],
      timestamp: doc['timestamp'],
      // location: doc['location'],
    );
  }

  Review({
    this.id,
    this.authorId,
    this.text,
    this.category,
    // this.image,
    this.timestamp,
    // this.location,
  });
}
