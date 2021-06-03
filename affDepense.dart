import 'dart:convert';
import 'package:flutter/material.dart';

class JsonPage extends StatefulWidget {
  @override
  _JsonPageState createState() => _JsonPageState();
}

class _JsonPageState extends State<JsonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Affichage des dépenses de la catégories"),
        backgroundColor: Color.fromRGBO(0, 209, 254, 100),
      ),
      body: Center(
        child: FutureBuilder(
          //normalement response de l'api mais pour le test on lit un fichier json
          future: DefaultAssetBundle.of(context).loadString("assets/test.json"),
          builder: (context, snapshot) {
            var dataApi = json.decode(snapshot.data.toString());
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              dataApi[index]['libelleD'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              dataApi[index]['montantD'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            /*padding: EdgeInsets.fromLTRB(
                                0, 0, MediaQuery.of(context).size.width / 6, 0),*/
                            child: Align(
                              child: Text(
                                dataApi[index]['dateD'].toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: dataApi.length,
            );
          },
        ),
      ),
    );
  }
}

