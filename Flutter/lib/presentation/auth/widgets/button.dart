import 'package:flutter/material.dart';
import 'package:team_g/domain/service/auth_api.dart';

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 2.2,
            bottom: 50,
          ),
        ),
        roundedRectButton(
          "はじめる",
          signInGradients,
        ),
      ],
    );
  }
}

Widget roundedRectButton(String title, List<Color> gradient) {
  return Builder(builder: (BuildContext mContext) {
    return Padding(
      padding: const EdgeInsets.only(left: 80, bottom: 10),
      child: Stack(
        alignment: const Alignment(1.0, 0.0),
        children: <Widget>[
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(mContext).size.width / 1.7,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: const EdgeInsets.only(top: 16, bottom: 16),
            ),
            onTap: () => {AuthService().signInAnonymous()},
          ),
        ],
      ),
    );
  });
}

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];
