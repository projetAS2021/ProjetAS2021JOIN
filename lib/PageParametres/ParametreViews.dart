import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ParametreControllers.dart';

class PageParametre extends StatefulWidget {
  @override
  _PageParametreState createState() => _PageParametreState();
}

class _PageParametreState extends State<PageParametre> {
  String boutonSelec = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Loyer',
                      style: TextStyle(fontSize: 15),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.article_sharp),
                            onPressed: () {},
                            tooltip: 'Renommer la catégorie',
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              supressionPage(context);
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
                child: Text("Répartition des dépenses pour cette catégorie"),
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
                        padding: EdgeInsets.only(left: 0, right: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Salaire 1'),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: TextField(
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: '...'),
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
                  onPressed: () {},
                  padding: EdgeInsets.all(20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'Enregistrer',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
