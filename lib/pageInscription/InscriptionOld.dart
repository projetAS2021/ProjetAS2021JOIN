// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_demo/components/AccountCheck.dart';
// import 'package:flutter_demo/components/JoinLogo.dart';
// import 'package:flutter_demo/components/TextFieldRectangle.dart';
// import 'package:flutter_demo/pageInscription/InscriptionController.dart';
// import 'package:flutter_demo/pageLogin/Login.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';

// class Inscription extends StatefulWidget {
//   @override
//   _InscriptionState createState() => _InscriptionState();
// }

// class _InscriptionState extends StateMVC<Inscription> {
//   _InscriptionState() : super(InscriptionController()) {
//     _co = InscriptionController.con;
//   }
//   InscriptionController? _co;

//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   //variables pour TextFormFields
//   TextEditingController dateCtl = TextEditingController();
//   DateTime? date = DateTime(1900);
//   String? mdp;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     _co!.context = context;
//     //SafeArea assure une zone d'affichage sûr qui prend en compte les différents écrans
//     return Scaffold(
//         key: _scaffoldKey,
//         body: SafeArea(
//           top: false,
//           bottom: false,
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(height: 30),
//                   JoinLogo(),
//                   Text.rich(
//                     TextSpan(
//                       text: "S'inscrire",
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   Container(
//                     //on met dans un container pour pouvoir modifier la taille des textfields, d'autres moyens de le faire
//                     margin: const EdgeInsets.only(left: 50, right: 50),
//                     child: Column(
//                       children: [
//                         TextFieldRectangle(
//                           hintText: 'Nom',
//                           onSaved: (String? value) {
//                             _co!.name = value;
//                           },
//                           onValidated: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Nom demandé';
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         TextFieldRectangle(
//                           hintText: 'Prénom',
//                           onSaved: (String? value) {
//                             _co!.firstName = value;
//                           },
//                           onValidated: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Prénom demandé';
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         TextFormField(
//                           controller: dateCtl,
//                           decoration: InputDecoration(
//                               labelText: "Date de naissance",
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.black,
//                                 ),
//                               )),
//                           onTap: () async {
//                             FocusScope.of(context)
//                                 .requestFocus(new FocusNode());
//                             date = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(1900),
//                                 lastDate: DateTime(2030));
//                             setState(() {
//                               dateCtl.text = '${date!.day}/${date!.month}/${date!.year}';}); //
//                           },
//                           onSaved: (String? value) {},
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Date de naissance demandée';
//                             } else if (DateTime.now().difference(date!).inDays < 365*18){
//                               return 'Vous devez avoir minimum 18 ans';
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         TextFieldRectangle(
//                           hintText: 'Email',
//                           onSaved: (String? value) {
//                             _co!.username = value;
//                           },
//                           onValidated: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Email demandé';
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         TextFieldRectangle(
//                           hintText: 'Mot de passe',
//                           hideText: true,
//                           onSaved: (String? value) {
//                             _co!.password = value;
//                           },
//                           onValidated: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Mot de passe incorrect';
//                             } else {
//                               mdp = value;
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         TextFieldRectangle(
//                           hintText: 'Confirmer mot de passe',
//                           hideText: true,
//                           onValidated: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Confirmation du mot de passe demandée';
//                             } else if(mdp != value) {
//                               return 'Veuillez entrer le même mot de passe';
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         TextFieldRectangle(
//                           hintText: 'Numéro de téléphone',
//                           hideText: true,
//                           onSaved: (String? value) {
//                             _co!.tel = value;
//                           },
//                           onValidated: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Numéro de téléphone demandé';
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                             mainAxisAlignment : MainAxisAlignment.center,
//                           children: <Widget>[
//                         Checkbox(
//                             value: _co!.cgu,
//                             activeColor: Colors.green,
//                             onChanged: (value){
//                               setState(() {_co!.cgu = value!;});
//                             }),
//                             Text('CGU')
//                         ]),
//                         SizedBox(height: 30),
//                         ElevatedButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all(
//                               Color.fromRGBO(210, 210, 210, 100),
//                             ),
//                           ),
//                           child: Text(
//                             "S'inscrire",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontFamily: 'Aileron',
//                             ),
//                           ),
//                           onPressed: () {
//                             _co!.handleSubmitted(_scaffoldKey,_formKey);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   AccountCheck(
//                     login: false,
//                     press: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Login(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }
