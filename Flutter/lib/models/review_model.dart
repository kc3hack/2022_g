import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String? id;
  String? authorId;
  String? text;
  String? category;
  String? image;
  Timestamp? timestamp;
  int? likes;
  int? comments;
  List? menus;
  bool? iscalender;

  Review(
      {this.id,
      this.authorId,
      this.text,
      this.category,
      this.image,
      this.timestamp,
      this.likes,
      this.comments,
      this.menus,
      this.iscalender});

  factory Review.fromDoc(DocumentSnapshot doc) {
    return Review(
      id: doc.id,
      authorId: doc['authorId'],
      text: doc['text'],
      category: doc['category'],
      image: doc['image'],
      timestamp: doc['timestamp'],
      likes: doc['likes'],
      iscalender: doc['iscalender'],
    );
  }
}
