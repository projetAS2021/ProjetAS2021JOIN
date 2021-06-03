import 'package:flutter/material.dart';
import '../constants.dart';

class AccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;

  const AccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login
                ? ""
                : "Tu as déjà un compte ? Alors, rendez-vous sur la page de ",
            style: TextStyle(color: Colors.black),
          ),
          GestureDetector(
            onTap: press,
            child: Text(
              login ? "S'inscrire" : "connexion",
              style: TextStyle(
                color: kPrimaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
    );
  }
}
