import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/services/Api.dart';
import 'package:flutter_demo/services/Categorie.dart';
import 'package:flutter_demo/constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'HomePageController.dart';
import 'package:flutter_demo/pageLogin/Login.dart';
import 'package:flutter_demo/pageCategorie/vueCategorie.dart';
import 'package:flutter_demo/services/Depense.dart';
import 'package:flutter_demo/services/User.dart';

class DepenseContainer extends StatelessWidget {
  Categorie? c;
  Color col;
  HomePageController? co;
  User? user;
  List<Depense>? depenses;
  List<String>? categories;
  GlobalKey<ScaffoldState>? _scaffoldKey;

  DepenseContainer(
      {Categorie? c,
      this.col = kColorContainer,
      HomePageController? co,
      User? user,
      List<Depense>? depenses,
      List<String>? categories,
      GlobalKey<ScaffoldState>? scaffoldKey}) {
    this.c = c;
    this.user = user;
    this.co = co;
    this.depenses = depenses;
    this.categories = categories;
    this._scaffoldKey = scaffoldKey;
  }
  void showInSnackBar(String value, GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VueCat(user: user!, titre: c!.nomCat!, depenses: depenses!)),
        ).then((_) => {co?.reloadPage()});
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: Column(
          children: [
            GestureDetector(
              onLongPress: () {
                print("double click sur nom cat");
                if (c!.nomCat! != "INCONNU") {
                  co!.changerNomCat(context, c!.nomCat!);
                  co!.reloadPage();
                } else {
                  showInSnackBar(
                      "Vous ne pouvez pas renommer la catégorie par défaut!",
                      _scaffoldKey!);
                }
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: FractionallySizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      color: col,
                    ),
                    child: Align(
                      child: Text(
                        c!.nomCat!,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    height: 40,
                  ),
                  widthFactor: 1,
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisSpacing: 0,
              childAspectRatio: 2.3,
              mainAxisSpacing: 0,
              crossAxisCount: 3,
              children: <Widget>[
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Total",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.black, width: 1),
                      left: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Pourcentage",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
//pas de bordure ici pour régler un pb que j'avais, je pouvais pas faire le border radius du bas tant que j'avais pas mis 4 bordures, il y avait donc un décalage
                ),
//VOTRE PARTICIPATION
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Votre participation",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
//MONTANT TOTAL
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      c!.total.toString() + "€",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
//POURCENTAGE PARTICIPATION
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      c!.pourc.toString() + "%",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                        width: 0,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),

//MONTANT DE VOTRE PARTICIPATION
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      c!.participation.toString() + "€",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
