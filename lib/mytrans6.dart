class Mytrans6 {
  String _namaKas;

  Mytrans6(
    this._namaKas,
  );

  Mytrans6.map(dynamic obj) {
    this._namaKas = obj["namaKas"];
  }

  String get namaKas => _namaKas;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["namaKas"] = _namaKas;

    return map;
  }
}
