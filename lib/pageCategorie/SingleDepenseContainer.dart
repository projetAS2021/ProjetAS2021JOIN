import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/services/Api.dart';
import 'package:flutter_demo/services/Categorie.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/services/Depense.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:flutter_demo/pageLogin/Login.dart';
import 'package:flutter_demo/pageCategorie/vueCategorie.dart';
import 'package:flutter_demo/services/User.dart';

import 'controllerCategorie.dart';

class SingleDepenseContainer extends StatefulWidget {
  Depense? depense;
  int? numU;
  List<dynamic>? categories;
  dynamic test;
  ControllerCategorie? _co;

  @override
  State<StatefulWidget> createState() {
    return _SingleDepenseContainer(
        depense: depense!, numU: numU!, co: _co!, cat: categories!);
  }

  SingleDepenseContainer(
      {required Depense depense,
      required int numU,
      required ControllerCategorie co,
      required List<dynamic> cat})
      : this.depense = depense,
        this.numU = numU,
        this.categories = cat,
        this._co = co;
}

class _SingleDepenseContainer extends State<SingleDepenseContainer> {
  Depense? depense;
  int? numU;
  List<dynamic>? categories;
  dynamic test;

  ControllerCategorie? _co;
  _SingleDepenseContainer(
      {required Depense depense,
      required int numU,
      required ControllerCategorie co,
      required List<dynamic> cat}) {
    this.depense = depense;
    this.numU = numU;
    this._co = co;
    this.categories = cat;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print(categories);
        showDialog(
            context: context,
            builder: (_) => PopupChangementCat(
                depense: depense!, numU: numU!, cat: categories!));
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  depense!.numU == numU ? "Vous" : "Votre partenaire",
                ),
              ),
              Expanded(
                child: Text(depense!.montantD.toString() + "€",
                    textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text(
                  depense!.dateD!,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          color: depense!.numU == numU ? Colors.green[500] : Colors.blue[500],
          alignment: Alignment.centerLeft,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Text(depense!.libelleD!),
          color: depense!.numU == numU ? Colors.green[200] : Colors.blue[200],
        )
      ]),
    );
  }
}
