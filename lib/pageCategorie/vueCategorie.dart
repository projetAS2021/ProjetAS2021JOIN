import 'package:flutter/material.dart';
import 'package:flutter_demo/components/JoinLogo.dart';
import 'package:flutter_demo/pageCategorie/SingleDepenseContainer.dart';
import 'package:flutter_demo/pageCategorie/controllerCategorie.dart';
import 'package:flutter_demo/services/Api.dart';
import 'package:flutter_demo/services/Depense.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_demo/services/User.dart';

// pour la partie parametres de la page categorie
import 'package:flutter_demo/PageParametres/ParametreControllers.dart';

// ignore: must_be_immutable
class VueCat extends StatefulWidget {
  User user;
  String titre;
  List<Depense> depenses;

  @override
  State<StatefulWidget> createState() {
    return _Categorie(user: user, titre: titre, depenses: depenses);
  }

  VueCat(
      {required User user,
      required String titre,
      required List<Depense> depenses})
      : this.user = user,
        this.titre = titre,
        this.depenses = depenses;
}

class _Categorie extends StateMVC<VueCat> {
  User? user;
  String? titre;
  List<Depense>? depenses;
  List<Depense> depensesCat = [];
  ControllerCategorie? _co;
  dynamic? categories;
  JoinLogo logo = new JoinLogo();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _Categorie({this.user, this.titre, this.depenses})
      : super(ControllerCategorie()) {
    _co = ControllerCategorie.con;
    _co?.UserParam = user;
    _co?.nomCategorie = this.titre;
    _co?.depense = this.depenses;
  }

  String boutonSelec = 'btn1';
  nouvelleListe() {
    for (var d in depenses!) {
      if (d.nomCat == _co?.nomCategorie) {
        depensesCat.add(d);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        depenses = [];
      });
      categories = getAllCat(user!.numU!);
    });
  }

  void showInSnackBar(String value, GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    String nomCategorie = _co?.nomCategorie ?? "Inconnu";
    TextEditingController salaire1Controller = new TextEditingController();
    TextEditingController salaire2Controller = new TextEditingController();
    TextEditingController manuel = new TextEditingController();
    nouvelleListe();
    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            var c = snapshot.data! as List<dynamic>;
            print(c);
            return SafeArea(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    title: logo.afficherLogoBlanc(),
                    elevation: 0,
                    backgroundColor: Colors.lightBlueAccent,
                    centerTitle: true,
                    bottom: TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.list)),
                        Tab(icon: Icon(Icons.settings)),
                      ],
                      indicatorWeight: 4.0,
                      indicatorColor: Colors.blueGrey,
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        _co?.changerTitre(
                                            context, nomCategorie);
                                      },
                                      child: Text(
                                        '$nomCategorie',
                                        //----------------------------------------------------------------------------------------
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(Icons.article_sharp),
                                              tooltip: 'renommer catégorie',
                                              onPressed: () {
                                                if (nomCategorie != "INCONNU") {
                                                  _co?.changerTitre(
                                                      context, nomCategorie);
                                                } else {
                                                  showInSnackBar(
                                                      "Vous ne pouvez pas renommer la catégorie par défaut!",
                                                      _scaffoldKey);
                                                }
                                              }),
                                          IconButton(
                                              icon: Icon(Icons.delete),
                                              tooltip: 'supprimer catégorie',
                                              onPressed: () {
                                                if (nomCategorie != "INCONNU") {
                                                  _co?.supprimerCategorie(
                                                      context);
                                                } else {
                                                  showInSnackBar(
                                                      "Vous ne pouvez pas supprimer la catégorie par défaut!",
                                                      _scaffoldKey);
                                                }
                                              } //fonction a faire plus tard
                                              ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: depensesCat.length,
                                itemBuilder: (context, index) {
                                  return SingleDepenseContainer(
                                    depense: depensesCat[index],
                                    numU: user!.numU!,
                                    co: _co!,
                                    cat: c,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '$nomCategorie',
                                      //----------------------------------------------------------------------------------------
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          IconButton(
                                            icon:
                                                const Icon(Icons.article_sharp),
                                            onPressed: () {
                                              _co?.changerTitre(
                                                  context, nomCategorie);
                                            },
                                            tooltip: 'Renommer la catégorie',
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              _co?.supprimerCategorie(context);
                                            },
                                            tooltip: 'Supprimer la page',
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 100),
                                child: Text(
                                    "Répartition des dépenses pour cette catégorie"),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                width: 300,
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 'btn1',
                                        groupValue: boutonSelec,
                                        onChanged: (val) {
                                          boutonSelec = val.toString();
                                          setState(() {});
                                        }),
                                    Text("50/50")
                                  ],
                                ),
                              ),
                              Container(
                                width: 300,
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 'btn2',
                                        groupValue: boutonSelec,
                                        onChanged: (val) {
                                          boutonSelec = val.toString();
                                          setState(() {});
                                        }),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 0, right: 10),
                                        child: TextField(
                                          controller: salaire1Controller,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Salaire 1'),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 16),
                                        child: TextField(
                                          controller: salaire2Controller,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Salaire 2'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 300,
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                        value: 'btn3',
                                        groupValue: boutonSelec,
                                        onChanged: (val) {
                                          boutonSelec = val.toString();
                                          setState(() {});
                                        }),
                                    Flexible(
                                      child: TextField(
                                        controller: manuel,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: '...'),
                                      ),
                                    ),
                                    Text("%")
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 40, right: 40),
                                child: RaisedButton(
                                  onPressed: () {
                                    int pourCat = 0;
                                    switch (boutonSelec) {
                                      case 'btn1':
                                        pourCat = 50;
                                        showInSnackBar(
                                            "Les pourcentages ont bien été mis à jour",
                                            _scaffoldKey);
                                        break;
                                      case 'btn2':
                                        if (salaire1Controller.text
                                                    .toString() !=
                                                "" &&
                                            salaire2Controller.text
                                                    .toString() !=
                                                "") {
                                          int sal1 = int.parse(
                                              salaire1Controller.text);
                                          int sal2 = int.parse(
                                              salaire2Controller.text);
                                          pourCat =
                                              ((sal1 / (sal1 + sal2)) * 100)
                                                  .round();
                                        }
                                        showInSnackBar(
                                            "Les pourcentages ont bien été mis à jour",
                                            _scaffoldKey);
                                        break;
                                      case 'btn3':
                                        if (manuel.text.toString() != "") {
                                          pourCat = int.parse(manuel.text);
                                          // set min and max values
                                          if (pourCat < 0 || pourCat > 100) {
                                            pourCat = -1;
                                            showInSnackBar(
                                                "Vous devez mettre un pourcentage correct (entre 0 et 100 inclus)",
                                                _scaffoldKey);
                                          }
                                        }
                                        break;
                                      default:
                                        print("rip");
                                    }

                                    if (pourCat != -1) {
                                      enregistrerPourcCat(
                                          titre!, pourCat, user!.numU!);
                                    }
                                  },
                                  padding: EdgeInsets.all(20.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    'Enregistrer',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        },
        future: categories);
  }
}
