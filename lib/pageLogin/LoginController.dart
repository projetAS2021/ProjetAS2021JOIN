import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/services/Api.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_demo/services/ApiResponse.dart';
import 'package:flutter_demo/services/ApiError.dart';
import 'package:flutter_demo/services/User.dart';

class LoginController extends ControllerMVC {
  factory LoginController() {
    if (_this == null) {
      _this = LoginController._();
    }
    return _this!;
  }
  static LoginController? _this;
  LoginController._();

  String? _username, _password;
  BuildContext? _context;
  set username(value) => _username = value;
  set password(value) => _password = value;
  set context(value) => _context = value;

  static LoginController get con => _this!;

  void showInSnackBar(String value, GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

  void handleSubmitted(GlobalKey<ScaffoldState> scaffoldKey,
      GlobalKey<FormState> formKey) async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showInSnackBar('Veuillez corriger vos renseignements!', scaffoldKey);
    } else {
      form.save();
      ApiResponse _apiResponse = await connection(_username!, _password!);
      // ignore: unnecessary_null_comparison
      if (_apiResponse.apiError == null) {
        Navigator.pushNamedAndRemoveUntil(
            _context!, '/home', ModalRoute.withName('/home'),
            arguments: (_apiResponse.data as User));
      } else {
        showInSnackBar((_apiResponse.apiError as ApiError).error!, scaffoldKey);
        setState(() {});
      }
    }
  }

  Future donnerCode(BuildContext context, String args) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Merci pour votre inscription!\nVeuillez noter et conserver le code ci-dessous pour le donner à l\'utilisateur qui partagera son compte avec vous.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          content: Text(
            "$args",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
