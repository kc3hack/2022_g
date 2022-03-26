import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:team_g/domain/service/database_api.dart';
import 'package:team_g/models/review_model.dart';

class CreateReviewScreen extends StatefulWidget {
  final String currentUserId;

  const CreateReviewScreen({Key? key, required this.currentUserId})
      : super(key: key);
  @override
  _CreateReviewScreenState createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  String? _reviewText;
  // XFile? _pickedImage;
  bool _loading = false;
  List<String> _items = ["おにぎり", "パン", "飲み物", "お菓子", "揚げ物"];
  int selectedCategoryIndex = 0;
  int selectedDayIndex = 0;
  String category = "おにぎり";

  // handleImageFromGallery() async {
  //   try {
  //     XFile imageFile = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //     ) as XFile;
  //     setState(() {
  //       _pickedImage = imageFile;
  //       print(_pickedImage);
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Widget categoryRadio(String text, int index) {
    return NeumorphicRadio(
      child: SizedBox(
        height: 45,
        width: 60,
        child: Center(
          child: Text(text),
        ),
      ),
      style: NeumorphicRadioStyle(
          selectedColor: Color.fromARGB(255, 183, 204, 237),
          unselectedColor: Colors.white,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15))),
      value: index,
      groupValue: selectedCategoryIndex,
      onChanged: (value) {
        setState(() {
          selectedCategoryIndex = value as int;
          category = _items[selectedCategoryIndex];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "口コミ・投稿",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            TextButton(
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                if (_reviewText!.isNotEmpty) {
                  String image;
                  // ignore: unnecessary_null_comparison
                  // if (_pickedImage == null) {
                  //   image = '';
                  // } else {
                  //   image =
                  //       await StorageService.uploadTweetPicture(_pickedImage!);
                  // }
                  Review review = Review(
                    text: _reviewText,
                    category: category,
                    // image: image,
                    authorId: widget.currentUserId,
                    timestamp: Timestamp.fromDate(
                      DateTime.now(),
                    ),
                    id: '',
                  );
                  DatabaseServices.createReview(review);
                  Navigator.pop(context);
                }
                setState(() {
                  _loading = false;
                });
              },
              child: const Text(
                "投稿",
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(children: [
                  _loading
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 250),
                              Column(
                                children: [
                                  // Center(
                                  //   child:
                                  //       SpinKitPouringHourGlassRefined(
                                  //     color: Palette.yellow,
                                  //     size: 100,
                                  //   ),
                                  // ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '投稿中です...',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16.0),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    categoryRadio(_items[0], 0),
                                    categoryRadio(_items[1], 1),
                                    categoryRadio(_items[2], 2),
                                    categoryRadio(_items[3], 3),
                                    categoryRadio(_items[4], 4),
                                  ],
                                )),
                            Container(
                              padding: const EdgeInsets.all(30),
                              child: TextField(
                                maxLength: 255,
                                maxLines: null,
                                cursorColor: Colors.black54,
                                decoration: const InputDecoration(
                                  hintText: "レビューをお書きください",
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 2),
                                  ),
                                ),
                                onChanged: (value) {
                                  _reviewText = value;
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            // _pickedImage == null
                            //     ? SizedBox.shrink()
                            //     : Column(
                            //         children: [
                            //           Container(
                            //             height: 200,
                            //             decoration: BoxDecoration(
                            //                 borderRadius:
                            //                     BorderRadius.circular(
                            //                         10),
                            //                 color: Palette.white,
                            //                 image: DecorationImage(
                            //                   fit: BoxFit.cover,
                            //                   image: FileImage(File(
                            //                       _pickedImage!.path)),
                            //                 )),
                            //           ),
                            //           SizedBox(height: 20),
                            //         ],
                            //       ),
                          ],
                        ),
                ]))));
  }
}
