import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_g/constants/constants.dart';
import 'package:team_g/presentation/ranking/widgets/ranking_widget.dart';
import 'package:team_g/presentation/review/add_review_page.dart';
import 'package:team_g/presentation/review/map_page.dart';
import 'package:team_g/presentation/review/widgets/review_container_widget.dart';
import 'package:provider/provider.dart';
import 'package:team_g/provider/reviews_provider.dart';
import 'package:team_g/provider/user_score_provider.dart';

class scoreRankingPage extends StatefulWidget {
  const scoreRankingPage({
    Key? key,
  }) : super(key: key);

  @override
  _scoreRankingPageState createState() => _scoreRankingPageState();
}

class _scoreRankingPageState extends State<scoreRankingPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildPages(UserScoresProvider userScoresProvider) {
    return ScoreRankingWidget(userScoresProvider: userScoresProvider);
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => UserScoresProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                elevation: 0.5,
                backgroundColor: Colors.white,
                centerTitle: true,
                title: const Text(
                  "ランキング",
                  style: TextStyle(color: Colors.black),
                )),
            body: Consumer<UserScoresProvider>(
              builder: (context, UserScoresProvider, _) =>
                  _buildPages(UserScoresProvider),
            ),
          ),
        ),
      );
}
