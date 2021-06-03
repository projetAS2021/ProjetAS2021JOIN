import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';

class JoinLogo extends StatelessWidget {
  @override
  afficherLogoBlanc() {
    return Text.rich(
      TextSpan(
        text: 'Join.',
        style: TextStyle(
          fontFamily: "Aileron",
          color: Colors.white,
          fontSize: 50.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          letterSpacing: -3,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Join.',
        style: TextStyle(
          fontFamily: "Aileron",
          color: kPrimaryColor,
          fontSize: 100.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          letterSpacing: -3,
        ),
      ),
    );
  }
}
