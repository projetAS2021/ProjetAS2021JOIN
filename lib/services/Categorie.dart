class Categorie{
  String? _nomCat;
  int _total = 0;
  int _pourc = 0;
  int _participation = 0;

  Categorie({String? nomCat, int total = 0, int pourc = 0, int participation = 0}){
    this._nomCat = nomCat;
    this._total = total;
    this._pourc = pourc;
    this._participation = participation;
}

  int get total => _total;
  set total(int value) {
    _total = value;
  }

  String? get nomCat => _nomCat;
  set nomCat(String? value) {
    _nomCat = value;
  }

  int get pourc => _pourc;
  set pourc(int value) {
    _pourc = value;
  }

  int get participation => _participation;
  set participation(int value) {
    _participation = value;
  }
}