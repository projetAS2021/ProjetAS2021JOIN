import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

supressionPage(BuildContext context) {
  return CupertinoAlertDialog(
    title: Text('Vouslez vous supprimer cette catégorie ?'),
    actions: <Widget>[
      CupertinoDialogAction(
        child: Text('Oui'),
        onPressed: () {},
      ),
      CupertinoDialogAction(
        child: Text('Non'),
        onPressed: () {},
      ),
    ],
  );
}

renommerPage(BuildContext context) {
  return TextField();
}
