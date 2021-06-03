class User {
  int? _numU;
  String? _email;
  String? _nomU;
  String? _prenom;
  String? _mdpU;
  bool _isUser1 = true;

  User({int? numU, String? email, String? nomU, String? prenom, String? mdpU}) {
    this._numU = numU;
    this._email = email;
    this._nomU = nomU;
    this._prenom = prenom;
    this._mdpU = mdpU;
  }

// Properties
  int? get numU => _numU;

  String? get email => _email;

  String? get nomU => _nomU;

  String? get prenom => _prenom;

  String? get mdpU => _mdpU;

  bool get isUser1 => _isUser1;

// create the user object from json input
  User.fromJson(Map<String, dynamic> json) {
    _numU = json['numU'];
    _email = json['email'];
    _nomU = json['nomU'];
    _prenom = json['prenom'];
    _mdpU = json['mdpU'];
    _isUser1 = json['isUser1'] == 1;
  }

// exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this._email;
    data['nomU'] = this._nomU;
    data['prenom'] = this._prenom;
    data['mdpU'] = this._mdpU;
    return data;
  }
}
