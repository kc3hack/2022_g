import 'package:flutter/material.dart';
import 'package:team_g/constants/constants.dart';
import 'package:team_g/models/review_model.dart';
import 'package:team_g/provider/reviews_provider.dart';

import 'review_container_widget.dart';

class TimeLineWidget extends StatefulWidget {
  final ReviewsProvider reviewsProvider;

  const TimeLineWidget({
    required this.reviewsProvider,
    Key? key,
  }) : super(key: key);

  @override
  _TimeLineWidgetState createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  List<Review> _reviews = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    setupAllReviews(widget.reviewsProvider);
  }

  @override
  void dispose() {
    super.dispose();
  }

  setupAllReviews(ReviewsProvider reviewsProvider) async {
    setState(() {
      _loading = true;
    });
    print("-------------------------setupAllreviews-----------------------");
    print(reviewsProvider.reviews);
    await reviewsProvider.fetchNextReviews();
    List<Review> reviews = reviewsProvider.reviews;
    print("--------------------------reviews--------------------${reviews}");
    print("setup");
    reviews.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    if (mounted) {
      //widgetTreeのエラー修正(https://blog.mrym.tv/2019/12/traps-on-calling-setstate-inside-initstate/)
      return setState(() {
        _reviews = reviews;
        _loading = false;
      });
    }
  }

  showAllReviews() {
    List<Widget> followingReviewsList = [];
    for (Review review in _reviews) {
      followingReviewsList.add(buildReviews(review));
    }
    return followingReviewsList;
  }

  buildReviews(Review review) {
    return ReviewContainer(
      review: review,
    );
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => setupAllReviews(widget.reviewsProvider),
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
                              'ツイートを探しています',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        ]
                      : showAllReviews(),
                ),
              ],
            )
          ],
        ),
      );
}
