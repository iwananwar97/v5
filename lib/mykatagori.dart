class Mykatagori {
  int id;
  String _nama;
  String _jenis;
  String _st;

  Mykatagori(
    this._nama,
    this._jenis,
    this._st,
  );

  Mykatagori.map(dynamic obj) {
    this._nama = obj["nama"];
    this._jenis = obj["jenis"];
    this._st = obj["st"];
  }

  String get nama => _nama;
  String get jenis => _jenis;
  String get st => _st;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["nama"] = _nama;
    map["jenis"] = _jenis;
    map["st"] = _st;

    return map;
  }

  void setKatagoriId(int id) {
    this.id = id;
  }
}
