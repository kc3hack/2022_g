import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:team_g/constants/constants.dart';
import 'package:team_g/presentation/review/add_review_page.dart';

class PostPage extends ConsumerWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _searchController = TextEditingController();

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.5,
      //   backgroundColor: Colors.grey[200],
      //   title: TextField(
      //     controller: _searchController,
      //     cursorColor: Palette.yellow,
      //     decoration: InputDecoration(
      //         fillColor: Colors.grey[200],
      //         contentPadding: EdgeInsets.symmetric(vertical: 15),
      //         hintText: 'エリア・ジャンルなど',
      //         hintStyle: const TextStyle(color: Colors.grey),
      //         border: InputBorder.none,
      //         prefixIcon: Icon(Icons.search, color: Colors.black),
      //         suffixIcon: TextButton(
      //           child: const Text("詳細条件"),
      //           onPressed: () {
      //             // clearSearch();
      //           },
      //         )),
      //   ),
      // ),
      body: SafeArea(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(10, 10))
                            ],
                          ),
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                // 検索フォーム
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    color: Colors.grey[500],
                                    icon: Icon(Icons.arrow_back_ios_new),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  hintText: '場所を検索',
                                  hintStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  border: InputBorder.none,
                                ),
                              ))),
                    ],
                  ),
                ),
              ]))),
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
    );
  }
}
