import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/PageParametres/ParametreViews.dart';
import 'package:flutter_demo/components/JoinLogo.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/homePage/DepenseContainer.dart';
import 'package:flutter_demo/homePage/principalePage.dart';
import 'package:flutter_demo/pageParametresGlobaux/ParametresGlobaux.dart';
import 'package:flutter_demo/services/Api.dart';
import 'package:flutter_demo/services/Categorie.dart';
import 'package:flutter_demo/services/Depense.dart';
import 'package:flutter_demo/services/DepenseList.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_demo/services/User.dart';

import 'HomePageController.dart';
import 'chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {
  _HomePageState() : super(HomePageController()) {
    _co = HomePageController.con;
  }
  HomePageController? _co;

  PageController _controller = PageController(
    initialPage: 0,
  );

  /*JoinLogo logo = new JoinLogo();
  double _padding = 30;*/

  JoinLogo logo = new JoinLogo();

  var args;
  Future<DepenseList>? depenses;
  Future<String>? categories;

  List<Depense>? listDepenses;

  @override
  void initState() {
    super.initState();
    /*Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context)!.settings.arguments;
        _co!.numeroU = args.numU;
      });*/
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        args = ModalRoute.of(context)!.settings.arguments;
        _co!.numeroU = args.numU;
      });

      _co?.depenses = getUserDetails(args.numU!);
    });
  }

  void updateView() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as User;
    return PageView(
      controller: _controller,
      children: [
        PrincipalePage(co: _co, u: args),
        Chart(co: _co, u: args),
      ],
    );
  }

  /*return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            var d = snapshot.data! as DepenseList;
            List<String> c = []; //d.getCategorie!;
            var montantDu = d.montantDu(args.numU!, args.isUser1);
            return SafeArea(
              child: Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  title: logo.afficherLogoBlanc(),
                  centerTitle: true,
                  titleSpacing: 0,
                  backgroundColor: kPrimaryColor,
                  elevation: 0,
                  actions: <Widget>[
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _co!.creerCategorie(context, _scaffoldKey);
                            // popup msg
                            setState(() {});
                            //méthode à appeler pour afficher un alert dialog comme changerNom2(context) mais pour les paramètres
                          },
                        ),
                        PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          onSelected: (result) {
                            if (result == 2) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParametreGlobaux(
                                    numU: args.numU,
                                  ),
                                ),
                              );
                            } else if (result == 1) {
                              _co!.importerCsv(args.numU!);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Text("Importer un relevé bancaire"),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: Text("Paramètres du compte"),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 30),
                        Container(
                          height: 40,
                          width: size.width / (5 / 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black, spreadRadius: 0.5),
                            ],
                          ),
                          //pour la position du texte dans le conteneur principale
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          //Conteneur pour le texte
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      0, 0, size.width / 6, 0),
                                  child: Align(
                                    child: Text(
                                      'TOTAL',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //Montant total (de chaque catégorie)
                              Expanded(
                                flex: 3,
                                child: Container(
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          spreadRadius: 0.5),
                                    ],
                                  ),
                                  child: Align(
                                    child: Text(
                                      d.totalDepense().toString() + "€",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        //fontFamily: 'Aileron',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          montantDu > 0
                              ? "Vous devez à votre partenaire " +
                                  montantDu.toStringAsFixed(2)
                              : "Votre partenaire vous doit " +
                                  montantDu.abs().toStringAsFixed(2),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: d
                              .depenseTotalParCategories(
                                  args.numU!, args.isUser1)
                              .categories
                              .length,
                          itemBuilder: (context, index) {
                            return DepenseContainer(
                              c: d
                                  .depenseTotalParCategories(
                                      args.numU!, args.isUser1)
                                  .categories[index],
                              col: cols[(index) % cols.length],
                              co: _co, //ref vers cette page pour pouvoir utiliser les fonctions dans le controlleur
                              user: args,
                              depenses: d.listDepenses,
                              categories: c,
                              scaffoldKey: _scaffoldKey,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        },
        future: _co?.depenses);
  }*/
}
