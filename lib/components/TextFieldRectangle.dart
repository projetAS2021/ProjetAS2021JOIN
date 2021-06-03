import 'package:flutter/material.dart';

typedef StringFunc = String? Function(String? s);

class TextFieldRectangle extends StatelessWidget {
  final String? hintText;
  final ValueChanged<String?>? onSaved;
  final StringFunc? onValidated;
  final bool hideText;

  TextFieldRectangle({
    this.hintText,
    this.onSaved,
    this.onValidated,
    this.hideText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      obscureText: hideText,
      onSaved: onSaved,
      validator: onValidated,
    );
  }
}
