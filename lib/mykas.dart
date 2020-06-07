class Mykas {
  int id;
  String _kas;
  String _tipe;

  Mykas(
    this._kas,
    this._tipe,
  );

  Mykas.map(dynamic obj) {
    this._kas = obj["kas"];
    this._tipe = obj["tipe"];
  }

  String get kas => _kas;
  String get tipe => tipe;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["kas"] = _kas;
    map["tipe"] = _tipe;

    return map;
  }

  void setkasId(int id) {
    this.id = id;
  }
}
