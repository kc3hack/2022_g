import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:team_g/models/review_model.dart';
import 'package:team_g/models/user_model.dart';

class ReviewContainer extends StatefulWidget {
  final Review review;
  final UserModel author;

  const ReviewContainer({Key? key, required this.review, required this.author})
      : super(key: key);
  @override
  _ReviewContainerState createState() => _ReviewContainerState();
}

class _ReviewContainerState extends State<ReviewContainer>
    with SingleTickerProviderStateMixin {
  var formatter = new DateFormat('yyyy/MM/dd HH:mm');
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(seconds: 2), vsync: this, value: 1);
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                      radius: 17,
                      backgroundImage: AssetImage('assets/placeholder.png')),
                  const SizedBox(width: 10),
                  Text(
                    "@ ${widget.author.uid}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(width: 5),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 40, top: 5, bottom: 5),
                  child: Text(
                    widget.review.text!,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )),
              const SizedBox(height: 5),
              // Column(
              //   children: [
              //     const SizedBox(height: 15),
              //     GestureDetector(
              //         onTap: () {
              //           // Navigator.push(
              //           //   context,
              //           //   CupertinoPageRoute(
              //           //     builder: (context) =>
              //           //         ImagePreview(image: widget.tweet.image!),
              //           //   ),
              //           // );
              //         },
              //         child: Container(
              //           height: 200,
              //           decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(10),
              //               image: DecorationImage(
              //                 fit: BoxFit.cover,
              //                 image: NetworkImage(widget.review.image!),
              //               )),
              //         ))
              //   ],
              // ),
              const SizedBox(height: 10),
              Text(
                formatter.format(widget.review.timestamp!.toDate()),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Positioned(
            //カテゴリーを右上に置く
            right: 1.0,
            top: 6.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10), //20,25
                  color: Colors.grey[300]),
              child: Text(
                widget.review.category!,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
