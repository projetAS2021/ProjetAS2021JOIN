import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/AccountCheck.dart';
import 'package:flutter_demo/components/JoinLogo.dart';
import 'package:flutter_demo/components/TextFieldRectangle.dart';
import 'package:flutter_demo/pageInscription/Inscription.dart';
import 'package:flutter_demo/pageLogin/LoginController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends StateMVC<Login> {
  _LoginState() : super(LoginController()) {
    _co = LoginController.con;
  }
  LoginController? _co;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var args;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context)!.settings.arguments ?? "";
      });
      if (args != "") {
        _co!.donnerCode(context, args as String);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _co!.context = context;
    //SafeArea assure une zone d'affichage sûr qui prend en compte les différents écrans
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: _formKey,
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  JoinLogo(),
                  Text.rich(
                    TextSpan(
                      text: 'Se connecter',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    //on met dans un container pour pouvoir modifier la taille des textfields, d'autres moyens de le faire
                    margin: const EdgeInsets.only(left: 50, right: 50),
                    child: Column(
                      children: [
                        TextFieldRectangle(
                          hintText: 'E-mail',
                          onSaved: (String? value) {
                            _co!.username = value;
                          },
                          onValidated: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Login incorrect';
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        TextFieldRectangle(
                          hintText: 'Mot de passe',
                          hideText: true,
                          onSaved: (String? value) {
                            _co!.password = value;
                          },
                          onValidated: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mot de passe incorrect';
                            }
                          },
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(210, 210, 210, 100),
                            ),
                          ),
                          child: Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Aileron',
                            ),
                          ),
                          onPressed: () {
                            _co!.handleSubmitted(_scaffoldKey, _formKey);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  AccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Inscription(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
