import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:team_g/models/review_model.dart';

class ReviewContainer extends StatefulWidget {
  final Review review;

  const ReviewContainer({
    Key? key,
    required this.review,
  }) : super(key: key);
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
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[350]!,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(left: 40, top: 5, bottom: 5),
                    child: Text(
                      widget.review.text!,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    )),
              ),
              const SizedBox(height: 5),
              widget.review.image!.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        const SizedBox(height: 15),
                        GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   CupertinoPageRoute(
                              //     builder: (context) =>
                              //         ImagePreview(image: widget.tweet.image!),
                              //   ),
                              // );
                            },
                            child: Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget.review.image!),
                                  )),
                            ))
                      ],
                    ),
              const SizedBox(height: 10),
              Text(
                formatter.format(widget.review.timestamp!.toDate()),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Divider()
        ],
      ),
    ));
  }
}

enum Menu { report_user, mute_user, block_user, share_tweet, delete_tweet }
