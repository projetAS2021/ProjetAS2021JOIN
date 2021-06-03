import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/services/Api.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class InscriptionController extends ControllerMVC {
  factory InscriptionController() {
    if (_this == null) {
      _this = InscriptionController._();
    }
    return _this!;
  }
  static InscriptionController? _this;
  InscriptionController._();

  String? _username, _password, _name, _firstName, _codeCompte;
  BuildContext? _context;
  set username(value) => _username = value;
  set password(value) => _password = value;
  set context(value) => _context = value;
  set name(value) => _name = value;
  set firstName(value) => _firstName = value;
  set codeCompte(value) => _codeCompte = value;

  static InscriptionController get con => _this!;

  bool _cgu = false;
  get cgu => _cgu;
  set cgu(value) => _cgu = value;

  void showInSnackBar(String value, GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

  void handleSubmitted(GlobalKey<ScaffoldState> scaffoldKey,
      GlobalKey<FormState> formKey) async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showInSnackBar('Veuillez corriger vos renseignements!', scaffoldKey);
    } else if (!cgu) {
      showInSnackBar('Veuillez cochez le CGU', scaffoldKey);
    } else {
      form.save();
      var codeRetour = await inscription(
          _username!, _name!, _firstName!, _password!, _codeCompte!);
      if (codeRetour[0] == -1) {
        showInSnackBar("Impossible de se connecter au serveur!", scaffoldKey);
        setState(() {});
      } else if (codeRetour[0] == -2) {
        showInSnackBar("Code de compte incorrect!", scaffoldKey);
        setState(() {});
      } else if (codeRetour[0] == -3) {
        showInSnackBar("Champ vide!", scaffoldKey);
        setState(() {});
      } else if (codeRetour[0] == -4) {
        showInSnackBar("Adresse mail déjà utilisée!", scaffoldKey);
        setState(() {});
      } else {
        Navigator.pushNamedAndRemoveUntil(
            _context!, '/login', ModalRoute.withName('/login'),
            arguments: (codeRetour[1] as String));
      }
    }
  }

  bool isValidEmail(String value) {
    String p = r'[a-zA-Z0-9]{1,}@[a-zA-Z0-9]{1,}.[a-zA-Z0-9]{1,}';
    RegExp regex = new RegExp(p);
    return regex.hasMatch(value);
  }

  afficherCGU(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: Text("Conditions générales d'utilisation :"),
              content: SingleChildScrollView(
                child: Text(
                    """Les présentes conditions générales d'utilisation (dites « CGU ») ont pour objet l'encadrement juridique des modalités de mise à disposition de l'application et des services par Join et de définir les conditions d’accès et d’utilisation des services par « l'Utilisateur ».

                    Toute inscription ou utilisation de l'application implique l'acceptation sans aucune réserve ni restriction des présentes CGU par l’utilisateur. Lors de l'inscription sur l'application via le Formulaire d’inscription, chaque utilisateur accepte expressément les présentes CGU en cochant la case « CGU ».
                    Le site assure à l'Utilisateur une collecte et un traitement d'informations personnelles dans le respect de la vie privée conformément à la loi n°78-17 du 6 janvier 1978 relative à l'informatique, aux fichiers et aux libertés.
                    En vertu de la loi Informatique et Libertés, en date du 6 janvier 1978, l'Utilisateur dispose d'un droit d'accès, de rectification, de suppression et d'opposition de ses données personnelles. L'Utilisateur exerce ce droit par mail à 'david.tchilian@universite-paris-saclay.fr'.

                    Les marques, logos, signes ainsi que tous les contenus de l'application (textes, images, son…) font l'objet d'une protection par le Code de la propriété intellectuelle et plus particulièrement par le droit d'auteur.
                    L'Utilisateur doit solliciter l'autorisation préalable de l'application pour toute reproduction, publication, copie des différents contenus. Il s'engage à une utilisation des contenus de l'application dans un cadre strictement privé, toute utilisation à des fins commerciales et publicitaires est strictement interdite.
                    Toute représentation totale ou partielle de ce site par quelque procédé que ce soit, sans l’autorisation expresse de l’exploitant de l'application constituerait une contrefaçon sanctionnée par l’article L 335-2 et suivants du Code de la propriété intellectuelle.
                    Il est rappelé conformément à l’article L122-5 du Code de propriété intellectuelle que l’Utilisateur qui reproduit, copie ou publie le contenu protégé doit citer l’auteur et sa source. 

                    L'Utilisateur s'assure de garder son mot de passe secret. Toute divulgation du mot de passe, quelle que soit sa forme, est interdite. Il assume les risques liés à l'utilisation de son identifiant et mot de passe. En cas de perte ou d'oubli de mot de passe, aucun service de récupération ne sera proposé. 
                    L'application décline toute responsabilité. """),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
