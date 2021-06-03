import 'package:flutter_demo/services/Categorie.dart';
import 'package:flutter_demo/services/CategorieList.dart';
import 'package:flutter_demo/services/Depense.dart';

class DepenseList {
  final List<Depense> depenses;
  List<String>? categories = [];
  List<String>? get getCategorie => categories;
  set setCategorie(value) => categories = value;

  DepenseList({required this.depenses}) {
    for (var d in depenses) {
      if (!categories!.contains(d.nomCat)) {
        categories!.add(d.nomCat!);
      }
    }
  }

  factory DepenseList.fromJson(List<dynamic> parsedJson) {
    List<Depense> depenses = List.empty();
    depenses = parsedJson.map((e) => Depense.fromJson(e)).toList();
    return new DepenseList(depenses: depenses);
  }
  List<Depense>? get listDepenses => this.depenses;

  int totalDepense() {
    int t = 0;
    for (var d in depenses) {
      t += d.montantD;
    }
    return t;
  }

  int totalDepenseParUser(int numU) {
    int t = 0;
    for (var d in depenses) {
      if (d.numU == numU) {
        t += d.montantD;
      }
    }
    return t;
  }

  CategorieList depenseTotalParCategories(int numU, bool isUser1) {
    CategorieList c;
    List<Categorie> cs = categories!.map((e) => Categorie(nomCat: e)).toList();

    for (var i in depenses) {
      for (var j in cs) {
        if (i.nomCat == j.nomCat) {
          j.total += i.montantD;
          if (i.numU == numU) {
            j.participation += i.montantD;
          }
        }
      }
    }

    if (isUser1) {
      for (var i in depenses) {
        for (var j in cs) {
          if (i.nomCat == j.nomCat) {
            j.pourc = i.pourcCat;
          }
        }
      }
    } else {
      for (var i in depenses) {
        for (var j in cs) {
          if (i.nomCat == j.nomCat) {
            j.pourc = 100 - i.pourcCat;
          }
        }
      }
    }

    c = new CategorieList(categories: cs);
    return c;
  }

  double montantDu(int numU, bool isUser1) {
    double t = 0;
    CategorieList c = depenseTotalParCategories(numU, isUser1);
    for (var e in c.categories) {
      t += (e.total * e.pourc / 100 - e.participation);
    }
    return t;
  }
}
