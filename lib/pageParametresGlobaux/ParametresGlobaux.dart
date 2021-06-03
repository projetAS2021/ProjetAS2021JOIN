import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/services/Api.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_demo/pageParametresGlobaux/ControllerParametresGlobaux.dart';
import 'package:flutter_demo/services/User.dart';

class ParametreGlobaux extends StatefulWidget {
  int? numU;

  ParametreGlobaux({this.numU});

  @override
  State<StatefulWidget> createState() {
    return _ParametreGlobauxState(this.numU!);
  }
}

class _ParametreGlobauxState extends StateMVC<ParametreGlobaux> {
  int numU;

  _ParametreGlobauxState(this.numU) : super(ControllerGlobaux()) {
    _co = ControllerGlobaux.con;
  }

  ControllerGlobaux? _co;
  int selectedIndex = 0;
  Widget _informations = Informations();
  Widget _ratio = Ratio();
  Widget _manuel = Manuel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètres de l\'application"),
      ),
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: "informations"),
          BottomNavigationBarItem(
            icon: Icon(Icons.drag_handle),
            label: "50/50",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            label: "Ratio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mode_edit),
            label: "Manuel",
          )
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._informations;
    } else if (this.selectedIndex == 1) {
      return Egalite(numU: this.numU);
    } else if (this.selectedIndex == 2) {
      return Ratio(numU: this.numU);
    } else {
      return Manuel(numU: this.numU);
    }
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}

TextStyle optionStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

class Informations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Choissisez de quelle façon vous voulez départager les dépenses. Attention cela sera effectif pour toutes les catégories!',
        style: optionStyle,
      ),
    );
  }
}

class Egalite extends StatelessWidget {
  int? numU;
  ControllerGlobaux? _co;

  Egalite({this.numU}): super(){

    _co = ControllerGlobaux.con;
}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("50/50: Toutes les dépenses seront partagées équitablement."),
          TextButton(
            onPressed: () {
              _co?.changerPourc(numU!, 50);
            },
            child: Text(
              'Enregistrer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class Ratio extends StatelessWidget {
  int? numU;
  ControllerGlobaux? _co;

  Ratio({this.numU}): super(){
    _co = ControllerGlobaux.con;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _saisie = new TextEditingController();
    TextEditingController _saisie2 = new TextEditingController();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Ratio: Toutes les dépenses seront partagées selon vos revenus."),
          TextField(
            controller: _saisie,
            decoration: InputDecoration(
              labelText: 'Mon salaire:',
              border: OutlineInputBorder(), //bordure sur le côté
              contentPadding: EdgeInsets.all(20.0),
            ),
          ),
          TextField(
            controller: _saisie2,
            decoration: InputDecoration(
              labelText: 'Salaire de l\'autre utilisateur:',
              border: OutlineInputBorder(), //bordure sur le côté
              contentPadding: EdgeInsets.all(20.0),
            ),
          ),
          TextButton(
            onPressed: () {
              int s1 = int.parse(_saisie.text);
              int s2 = int.parse(_saisie2.text);
              int pourc = (s1 * 100 / (s1 + s2)).floor();
              _co?.changerPourc(numU!, pourc);
            },
            child: Text(
              'Enregistrer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class Manuel extends StatelessWidget {
  int? numU;
  ControllerGlobaux? _co;

  Manuel({this.numU}): super(){
    _co = ControllerGlobaux.con;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _saisie = new TextEditingController();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Manuel: Toutes les dépenses seront partagées en fonction de ce que vous rentrerez (vous entrez le pourcentage que VOUS payez)"),
          TextField(
            controller: _saisie,
            decoration:
                InputDecoration(border: OutlineInputBorder(), hintText: 'x%'),
          ),
          TextButton(
            onPressed: () {
              _co?.changerPourc(numU!, int.parse(_saisie.text));
            },
            child: Text(
              'Enregistrer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
