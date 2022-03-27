import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:team_g/domain/service/auth_api.dart';
import 'package:team_g/domain/service/database_api.dart';

class GamePage extends StatefulWidget {
  GamePage({
    Key? key,
    required this.initCallback,
    required this.isInit,
  }) : super(key: key);

  VoidCallback initCallback;
  bool isInit;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  late UnityWidgetController unityWidgetController;

  void onUnityCreated(controller) async {
    this.unityWidgetController = await controller;
  }

  void onUnityMessage(message) {
    DatabaseServices.updateScore(message.toString());
    print("score${message.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.5, backgroundColor: Color.fromARGB(200, 60, 90, 87)),
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: Container(
          child: UnityWidget(
            onUnityCreated: onUnityCreated,
            onUnityMessage: onUnityMessage,
          ),
        ),
      ),
    );
  }
}
