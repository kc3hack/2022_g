import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_g/constants/constants.dart';
import 'package:team_g/domain/service/auth_api.dart';
import 'package:team_g/domain/service/database_api.dart';
import 'package:team_g/models/review_model.dart';
import 'package:team_g/models/user_model.dart';
import 'package:team_g/presentation/game/game_page.dart';
import 'package:team_g/presentation/review/widgets/review_container_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Review> _allReviews = [];
  void initCallback() {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => GamePage(
            isInit: false,
            initCallback: () {},
          ),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
  }

  getUserReviews() async {
    List<Review> userTweets =
        await DatabaseServices.getUserReviews(currentUserId);
    if (mounted) {
      setState(() {
        _allReviews = userTweets;
      });
    }
  }

  Widget buildReviewWidgets(UserModel author) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _allReviews.length,
        itemBuilder: (context, index) {
          return ReviewContainer(
            author: author,
            review: _allReviews[index],
          );
        });
  }

  @override
  void initState() {
    getUserReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: usersRef.doc(currentUserId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            UserModel author = UserModel.fromDoc(snapshot.data);
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(4, 9, 35, 1),
                        Color.fromRGBO(39, 105, 171, 1),
                      ],
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 40),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  AuthService().logout();
                                },
                                icon: const Icon(Icons.logout_rounded),
                                color: Colors.white,
                              ),
                              _allReviews.length <= 0
                                  ? Text(
                                      "商品をレビューしてください",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  GamePage(
                                                isInit: true,
                                                initCallback: initCallback,
                                              ),
                                              transitionDuration: Duration.zero,
                                              reverseTransitionDuration:
                                                  Duration.zero,
                                            ));
                                      },
                                      icon: const Icon(Icons.gamepad_rounded),
                                      color: Colors.white,
                                    ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'My\nProfile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontFamily: 'Nisebuschgardens',
                            ),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          SizedBox(
                            height: height * 0.43,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double innerHeight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: innerHeight * 0.72,
                                        width: innerWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 80,
                                            ),
                                            Text(
                                              author.uid,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 37,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Review',
                                                      style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontFamily: 'Nunito',
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                    Text(
                                                      _allReviews.length
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            39, 105, 171, 1),
                                                        fontFamily: 'Nunito',
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 25,
                                                    vertical: 8,
                                                  ),
                                                  child: Container(
                                                    height: 50,
                                                    width: 3,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Score',
                                                      style: TextStyle(
                                                        color: Colors.grey[700],
                                                        fontFamily: 'Nunito',
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                    Text(
                                                      author.score.toString(),
                                                      style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            39, 105, 171, 1),
                                                        fontFamily: 'Nunito',
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 110,
                                      right: 20,
                                      child: Icon(
                                        // AntDesign.setting,
                                        Icons.abc_outlined,
                                        color: Colors.grey[700],
                                        size: 30,
                                      ),
                                    ),
                                    Positioned(
                                      top: 40,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          child: Image.asset(
                                            'assets/placeholder.png',
                                            height: 100.0,
                                            width: 100.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: height * 0.5,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    'My Reviews',
                                    style: TextStyle(
                                      color: Color.fromRGBO(39, 105, 171, 1),
                                      fontSize: 27,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2.5,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  buildReviewWidgets(author)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        });
  }
}
