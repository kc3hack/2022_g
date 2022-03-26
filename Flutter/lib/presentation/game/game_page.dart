import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:team_g/domain/service/auth_api.dart';

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
  late UnityWidgetController unityWidgetController;

  void _onUnityCreated(controller) async {
    this.unityWidgetController = await controller;

    widget.isInit
        ? Future.delayed(
            Duration(milliseconds: 300),
            () async {
              await unityWidgetController.pause();
              Navigator.of(context).pop();
              Future.delayed(
                Duration(milliseconds: 500),
                () async {
                  widget.initCallback();
                },
              );
            },
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.5, backgroundColor: Color.fromARGB(200, 60, 90, 87)),
      body: UnityWidget(
        onUnityCreated: _onUnityCreated,
      ),
    );
  }
}
