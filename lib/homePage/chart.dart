import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/PageParametres/ParametreViews.dart';
import 'package:flutter_demo/components/JoinLogo.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/homePage/DepenseContainer.dart';
import 'package:flutter_demo/pageParametresGlobaux/ParametresGlobaux.dart';
import 'package:flutter_demo/services/Api.dart';
import 'package:flutter_demo/services/CategorieList.dart';
import 'package:flutter_demo/services/Depense.dart';
import 'package:flutter_demo/services/DepenseList.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_demo/services/User.dart';

import 'HomePageController.dart';
import 'package:pie_chart/pie_chart.dart';

class Chart extends StatelessWidget {
  Map<String, double>? dataMap;
  HomePageController? co;
  User? u;

  Chart({this.co, this.u}) {
    // dataMap = Map.fromIterable(co!.categories!.cat, key: (e) => e.nomCat, value: (e) => e.total);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            var d = snapshot.data! as DepenseList;
            var t = d.totalDepense();
            dataMap = Map.fromIterable(
                d.depenseTotalParCategories(u!.numU!, u!.isUser1).categories,
                key: (e) => e.nomCat,
                value: (e) => (e.total.toDouble() / t) * 100);
            return Scaffold(
              appBar: AppBar(
                //title: JoinLogo(color: Colors.white, size: 50),
                title: new JoinLogo().afficherLogoBlanc(),
                centerTitle: true,
                titleSpacing: 0,
                backgroundColor: kPrimaryColor,
                elevation: 0,
              ),
              body: PieChart(
                dataMap: dataMap!,
                animationDuration: Duration(milliseconds: 100),
                chartLegendSpacing: 50,
                chartRadius: size.width / 2,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 55,
                //centerText: "HYBRID",
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendTextStyle: TextStyle(
                      fontFamily: "Aileron",
                      color: Colors.black,
                      fontSize: 30.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        },
        future: co?.depenses);
  }
}
