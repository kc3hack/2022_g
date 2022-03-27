import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:team_g/constants/constants.dart';
import 'package:team_g/models/review_model.dart';
import 'package:team_g/models/user_model.dart';

class RankingContainer extends StatefulWidget {
  final UserModel author;

  const RankingContainer({Key? key, required this.author}) : super(key: key);
  @override
  _RankingContainerState createState() => _RankingContainerState();
}

class _RankingContainerState extends State<RankingContainer>
    with SingleTickerProviderStateMixin {
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
                    "${widget.author.score.toString()}点",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )),
              const SizedBox(height: 5),
              const SizedBox(height: 10),
            ],
          ),
          widget.author.id == currentUserId
              ? Positioned(
                  //カテゴリーを右上に置く
                  right: 1.0,
                  top: 6.0,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10), //20,25
                          color: Colors.white),
                      child: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )),
                )
              : SizedBox()
        ],
      ),
    ));
  }
}
