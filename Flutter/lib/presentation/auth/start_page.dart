import 'package:flutter/material.dart';
import 'package:team_g/presentation/auth/widgets/background.dart';
import 'package:team_g/presentation/auth/widgets/button.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: const <Widget>[
            Background(),
            Button(),
          ],
        ));
  }
}
