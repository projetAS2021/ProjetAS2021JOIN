import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/services/Api.dart';
import 'package:flutter_demo/services/CategorieList.dart';
import 'package:flutter_demo/services/Depense.dart';
import 'package:flutter_demo/services/DepenseList.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomePageController extends ControllerMVC {
  factory HomePageController() {
    if (_this == null) {
      _this = HomePageController._();
    }
    return _this!;
  }
  static HomePageController? _this;
  HomePageController._();

  static HomePageController get con => _this!;

  int? numU;
  set numeroU(value) => numU = value;

  Future<DepenseList>? ds;
  Future<DepenseList>? get depenses => ds;
  Future<String>? categories;
  set cats(value) => categories = value;
  set depenses(value) => ds = value;

  Future<CategorieList>? cat;
  Future<CategorieList>? get categorie => cat;
  set categorie(value) => cat = value;

  void showInSnackBar(String value, GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

  creerCategorie(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    TextEditingController _saisie = new TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Créer une catégorie'),
          content: TextField(
            controller: _saisie,
            decoration: InputDecoration(
              labelText: 'Nom de catégorie',
              border: OutlineInputBorder(), //bordure sur le côté
              contentPadding: EdgeInsets.all(20.0),
              //hintText: "Test d'affichage au dessus"),
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Créer'),
              onPressed: () {
                createCategorie(_saisie.text, numU!);

                showInSnackBar(
                    "La categorie a bien été créée mais elle est vide",
                    scaffoldKey);
                //reloadPage();

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  changerNomCat(BuildContext context, String oldNom) {
    TextEditingController _saisie = new TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Renommer'),
          content: TextField(
            controller: _saisie,
            decoration: InputDecoration(
              labelText: 'Saisissez le nouveau nom',
              border: OutlineInputBorder(), //bordure sur le côté
              contentPadding: EdgeInsets.all(20.0),
              //hintText: "Test d'affichage au dessus"),
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Valider'),
              onPressed: () {
                changeCatName(oldNom, _saisie.text, numU! /*_this!*/
                    );
                reloadPage();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void updateView() {
    setState(() {});
  }

  importerCsv(int numU) async {
    File selectedfile;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      //allowed extension to choose
    );
    if (result != null) {
      //if there is selected file
      selectedfile = File(result.files.single.path!);
      var csv;
      csvVersApi(await selectedfile.readAsString(), numU);
      Future.delayed(Duration(seconds: 1), () {
        reloadPage();
      });
      //await importerDepenses(csv, numU);
    }
  }

  csvVersApi(String csv, int numU) async {
    await importerDepenses(csv, numU);
  }

  void reloadPage() {
    setState(() {
      ds = getUserDetails(numU!);
    });
  }
}
