class Depense {
  int? _numD;
  int? _numU;
  String? _libelleD;
  String? _dateD;
  String? _nomCat;
  int? _numCpt;
  int _pourcCat = 0;
  int _montantD = 0;

  Depense({int? numD,int? numU,String? libelleD,String? dateD, String? nomCat, int? numCpt, required int pourcCat, required int montantD, required int total}){
    this._numD = numD;
    this._numU = numU;
    this._libelleD = libelleD;
    this._dateD = dateD;
    this._nomCat = nomCat;
    this._numCpt = numCpt;
    this._pourcCat = pourcCat;
    this._montantD = montantD;
  }

  int get montantD => _montantD;
  set montantD (value) => this._montantD = value;

  int get pourcCat => _pourcCat;
  set pourcCat(value) => this._pourcCat = value;

  int? get numCpt => _numCpt;

  String? get nomCat => _nomCat;

  String? get dateD => _dateD;

  String? get libelleD => _libelleD;

  int? get numU => _numU;

  int? get numD => _numD;

  Depense.fromJson(Map<String, dynamic> json) {
    _numU = json['numU'];
    _numD = json['numD'];
    _libelleD = json['libelleD'];
    _dateD = json['dateD'];
    _nomCat = json['nomCat'];
    _numCpt = json['numCpt'];
    _pourcCat= json['pourcCat'];
    _montantD = json['montantD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numD'] = this._numD;
    data['numU'] = this._numU;
    data['libelleD'] = this._libelleD;
    data['dateD'] = this._dateD;
    data['nomCat'] = this._nomCat;
    data['numCpt'] = this._numCpt;
    data['pourcCat'] = this._pourcCat;
    data['montantD'] = this._montantD;
    return data;
  }


}