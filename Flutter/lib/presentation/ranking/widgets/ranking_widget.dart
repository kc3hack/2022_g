import 'package:flutter/material.dart';
import 'package:team_g/constants/constants.dart';
import 'package:team_g/models/review_model.dart';
import 'package:team_g/models/user_model.dart';
import 'package:team_g/presentation/ranking/widgets/ranking_container.dart';
import 'package:team_g/provider/reviews_provider.dart';
import 'package:team_g/provider/user_score_provider.dart';

class ScoreRankingWidget extends StatefulWidget {
  final UserScoresProvider userScoresProvider;

  const ScoreRankingWidget({
    required this.userScoresProvider,
    Key? key,
  }) : super(key: key);

  @override
  _ScoreRankingWidgetState createState() => _ScoreRankingWidgetState();
}

class _ScoreRankingWidgetState extends State<ScoreRankingWidget> {
  List<UserModel> _users = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    setupAllScores(widget.userScoresProvider);
  }

  @override
  void dispose() {
    super.dispose();
  }

  setupAllScores(UserScoresProvider userScoresProvider) async {
    setState(() {
      _loading = true;
    });
    print("-------------------------setupAllreviews-----------------------");
    await userScoresProvider.fetchNextScores();
    List<UserModel> users = userScoresProvider.users;
    users.sort((a, b) => b.score.compareTo(a.score));
    if (mounted) {
      //widgetTreeのエラー修正(https://blog.mrym.tv/2019/12/traps-on-calling-setstate-inside-initstate/)
      return setState(() {
        _users = users;
        _loading = false;
      });
    }
  }

  showAllRankings() {
    List<Widget> followingUsersList = [];
    for (UserModel user in _users) {
      followingUsersList.add(buildReviews(user));
    }
    return followingUsersList;
  }

  buildReviews(UserModel author) {
    return RankingContainer(
      author: author,
    );
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
      onRefresh: () => setupAllScores(widget.userScoresProvider),
      child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            _loading
                ? const LinearProgressIndicator()
                : const SizedBox.shrink(),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 5),
                Column(
                  children: _loading == true
                      ? [
                          const SizedBox(height: 5),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              'ランキング計算中です・・・',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        ]
                      : showAllRankings(),
                ),
              ],
            )
          ]));
}
