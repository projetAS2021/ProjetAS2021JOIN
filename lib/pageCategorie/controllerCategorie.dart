import 'package:flutter/material.dart';
import 'package:flutter_demo/services/Api.dart';
import 'package:flutter_demo/services/Depense.dart';
import 'package:flutter_demo/services/User.dart';
import 'package:mvc_pattern/mvc_pattern.dart' as MVC;
import 'package:flutter/cupertino.dart';

class ControllerCategorie extends MVC.ControllerMVC {
  factory ControllerCategorie() {
    if (_this == null) _this = ControllerCategorie._();
    return _this!;
  }
  static ControllerCategorie? _this;

  ControllerCategorie._();

  /// Allow for easy access to 'the Controller' throughout the application.
  static ControllerCategorie get con => _this!;

  User? user;
  String? nomCat;
  List<Depense>? depenses;
  set UserParam(value) => user = value;
  String? get nomCategorie => nomCat;
  dynamic categories;
  set setCat(value) => user = value;
  String? get getCat => nomCat;
  set nomCategorie(value) => nomCat = value;
  List<Depense>? get depense => depenses;
  set depense(value) => depenses = value;

  changerTitre(BuildContext context, String oldName) {
    TextEditingController _saisie = new TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Renommer'),
          content: TextField(
            controller: _saisie,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Saisissez le nouveau nom',
              border: OutlineInputBorder(), //bordure sur le côté
              contentPadding: EdgeInsets.all(20.0),
              //hintText: "Test d'affichage au dessus"
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Valider'),
              onPressed: () {
                nomCategorie = _saisie.text;

                changeCatName(oldName, _saisie.text, user!.numU!);
                setState(() {
                  nomCat = _saisie.text;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  supprimerCategorie(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text("Voulez-vous supprimer cette catégorie ?"),
          actions: [
            ElevatedButton(
              child: Text('Confirmer'),
              onPressed: () async {
                supprimerCat(nomCat!, user!.numU!);
                Navigator.pop(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class PopupChangementCat extends StatefulWidget {
  Depense? depense;
  int? numU;
  List<dynamic>? categories;

  @override
  State<StatefulWidget> createState() {
    return _PopupChangementCat(
        depense: depense!, numU: numU!, cat: categories!);
  }

  PopupChangementCat(
      {required Depense depense, required int numU, required List<dynamic> cat})
      : this.depense = depense,
        this.numU = numU,
        this.categories = cat;
}

class _PopupChangementCat extends State<PopupChangementCat> {
  Depense? depense;
  int? numU;
  List<dynamic>? categories;
  String? choix;

  _PopupChangementCat(
      {required Depense depense,
      required int numU,
      required List<dynamic> cat}) {
    this.depense = depense;
    this.numU = numU;
    this.categories = cat;
  }
  @override
  void initState() {
    super.initState();
    choix = depense!.nomCat;
  }

  Widget build(BuildContext context) {
    List<String> c = [];
    for (int i = 0; i < categories!.length; i++) {
      if (!c.contains(categories![i]['nomCat']))
        c.add(categories![i]['nomCat']);
    }
    print(c);
    return new AlertDialog(
      title: Text('Changer de catégorie'),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return SingleChildScrollView(
          child: Container(
            height: 300,
            width: 100,
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: c.length,
              itemBuilder: (context, index) {
                return RadioListTile<String>(
                    title: Text(c[index]),
                    value: c[index],
                    groupValue: choix,
                    onChanged: (value) {
                      print(choix);
                      setState(() {
                        choix = value!;
                        print(choix);
                      });
                    });
              },
            ),
          ),
        );
      }),
      actions: [
        ElevatedButton(
          child: Text('Changer'),
          onPressed: () {
            if (choix != "") {
              changerDepenseCat(numU!, choix!, depense!.numD!);
              print(choix);
            }
            Navigator.pop(context);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
