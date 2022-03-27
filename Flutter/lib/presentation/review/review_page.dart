import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_g/constants/constants.dart';
import 'package:team_g/presentation/review/add_review_page.dart';
import 'package:team_g/presentation/review/map_page.dart';
import 'package:team_g/presentation/review/widgets/review_container_widget.dart';
import 'package:provider/provider.dart';
import 'package:team_g/provider/reviews_provider.dart';

import 'widgets/timeline_widget.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({
    Key? key,
  }) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildPages(ReviewsProvider reviewsProvider) {
    return TimeLineWidget(
      reviewsProvider: reviewsProvider,
    );
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ReviewsProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0.5,
              backgroundColor: Colors.white,
              title: TextField(
                // controller: _searchController,
                cursorColor: Palette.yellow,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  hintText: 'キーワードを検索',
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            body: Consumer<ReviewsProvider>(
              builder: (context, reviewsProvider, _) =>
                  _buildPages(reviewsProvider),
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: "HomeScreen",
              child: const Icon(
                Icons.post_add,
                color: Colors.white,
                size: 32.0,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => CreateReviewScreen(
                              currentUserId: currentUserId,
                            )));
              },
            ),
          ),
        ),
      );
}
