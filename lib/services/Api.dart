import 'dart:convert';
import 'dart:io';

import 'package:flutter_demo/homePage/HomePageController.dart';
import 'package:flutter_demo/services/DepenseList.dart';

import 'ApiError.dart';
import 'User.dart';
import 'ApiResponse.dart';
import 'package:http/http.dart' as http;

final _baseUrl = "https://webdev.iut-orsay.fr/prj-as-2021/api/";
final _authenticate = _baseUrl + 'connexion/';
final _inscription = _baseUrl + 'inscription/';
final _getDetail = _baseUrl + 'depenses/';
final _createCategorie = _baseUrl + 'categorie/';
final _changeCatName = _baseUrl + 'categorie/';
final _deleteCategorie = _baseUrl + 'categorie/';
final _changerPourcGlobal = _baseUrl + 'compte/';

Future<ApiResponse> connection(String email, String mdpU) async {
  ApiResponse _apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse(_authenticate),
        body: jsonEncode({
          'email': email,
          'mdpU': mdpU,
        }));

    switch (response.statusCode) {
      case 200:
        print('succes');
        _apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 500:
        _apiResponse.apiError =
            ApiError(error: "Mot de passe ou email incorrect");
        break;
      default:
        _apiResponse.apiError = ApiError(error: "Connection impossible");
        break;
    }
  } on SocketException {
    _apiResponse.apiError =
        ApiError(error: "Connection impossible. Réessayez plus tard!");
  }
  return _apiResponse;
}

Future<List<Object?>> inscription(String email, String nomU, String prenom,
    String mdpU, String codeCompte) async {
  var returnCode = List<Object?>.filled(2, 0);
  try {
    if (codeCompte.isEmpty) {
      codeCompte = "";
    }
    final response = await http.post(Uri.parse(_inscription),
        body: jsonEncode({
          "email": email,
          "nomU": nomU,
          "prenom": prenom,
          "mdpU": mdpU,
          "codeCompte": codeCompte
        }));

    switch (response.statusCode) {
      case 200:
        returnCode[0] = 1;
        returnCode[1] = jsonDecode(response.body)['codeCompte'];
        break;
      case 500:
        returnCode[0] = -1;
        break;
      case 460:
        returnCode[0] = -2;
        break;
      case 461:
        returnCode[0] = -3;
        break;
      case 462:
        returnCode[0] = -4;
        break;
      default:
        returnCode[0] = -1;
        break;
    }
  } on SocketException {
    returnCode[0] = -2;
  }
  return returnCode;
}

Future<DepenseList> getUserDetails(int userId) async {
  DepenseList depenses;
  final response = await http.get(Uri.parse(_getDetail + "?id=$userId"));

  if (response.statusCode == 200) {
    depenses = DepenseList.fromJson(jsonDecode(response.body));
    //depenses.setCategorie = await getAllCat(userId);
    return depenses;
  } else {
    throw Exception("Impossible de se connecter au serveur");
  }
}

Future<dynamic> getAllCat(int numU) async {
  //Future<List<String>> getAllCat(int numU) async {
  List<String> categories;
  String url = "https://webdev.iut-orsay.fr/prj-as-2021/api/categorie/?id=" +
      numU.toString();
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    categories = [];
    dynamic temp = jsonDecode(response.body);
    //return categories;
    print(temp);
    return temp;
  } else {
    throw Exception("Impossible de se connecter au serveur");
  }
}

Future<void> createCategorie(String nomCat, int numU) async {
  final response = await http.post(
    Uri.parse(_createCategorie),
    body: jsonEncode(
      {
        'nomCat': nomCat,
        'numU': numU,
      },
    ),
  );
}

Future<void> supprimerCat(String nomCat, int numU) async {
  print(numU);
  print(nomCat);
  final response = await http.delete(
    Uri.parse(_deleteCategorie),
    body: jsonEncode(
      {
        'nomCat': nomCat,
        'numU': numU,
      },
    ),
  );
}

Future<void> changeCatName(
  String oldNom,
  String newNom,
  int numU,
  /*HomePageController co*/
) async {
  final response = await http.put(
    Uri.parse(_changeCatName),
    body: jsonEncode(
      {
        'oldNom': oldNom,
        'newNom': newNom,
        'numU': numU,
      },
    ),
  );
  //co.updateView();
}

Future<void> changerDepenseCat(int numU, String nomCat, int numD) async {
  String url = "https://webdev.iut-orsay.fr/prj-as-2021/api/depenses/?id=" +
      numU.toString();
  print(nomCat);
  final response = await http.put(Uri.parse(url),
      body: jsonEncode(
        {'numU': numU, 'nomCat': nomCat, 'numD': numD},
      ));
  switch (response.statusCode) {
    case 200:
      print('succes');
      print(nomCat + " " + numU.toString() + " " + numD.toString());
      break;
    case 500:
      print("erreur interne au serveur");
      break;
    default:
      print("erreur côté client");
      break;
  }
}

Future<void> importerDepenses(String csv, int numU) async {
  String url =
      "https://webdev.iut-orsay.fr/prj-as-2021/api/releveBancaire/csvVersBd/?id=" +
          numU.toString();
  final response = await http.post(Uri.parse(url), body: csv);
}

Future<void> changerPourcGlobal(int numU, int pourc) async {
  final response = await http.put(
    Uri.parse(_changerPourcGlobal),
    body: jsonEncode(
      {
        'pourcCpt': pourc,
        'numU': numU,
      },
    ),
  );
}

Future<void> enregistrerPourcCat(String nomCat, int repart, int numU) async {
  int returnCode;
  String url = "https://webdev.iut-orsay.fr/prj-as-2021/api/categorie/";
  final response = await http.put(Uri.parse(url),
      body: jsonEncode({"nomCat": nomCat, "pourcCat": repart, "numU": numU}));

  switch (response.statusCode) {
    case 200:
      print("yahouuuu");
      break;
    case 500:
      print("dommage");
      break;
    default:
      print("dommage");
      break;
  }
}
