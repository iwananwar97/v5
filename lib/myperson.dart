class Myperson {
  int id;
  String _kode;
  String _namaKas;
  String _person;
  String _noTelp;
  String _alamat;
  String _jenisPerson;

  Myperson(
    this._kode,
    this._namaKas,
    this._person,
    this._noTelp,
    this._alamat,
    this._jenisPerson,
  );

  Myperson.map(dynamic obj) {
    this._kode = obj["kode"];
    this._namaKas = obj["namaKas"];
    this._person = obj["person"];
    this._noTelp = obj["no_noTelp"];
    this._alamat = obj["alamat"];
    this._jenisPerson = obj["jenisPerson"];
  }

  String get kode => _kode;
  String get namaKas => _namaKas;
  String get person => _person;
  String get noTelp => _noTelp;
  String get alamat => _alamat;
  String get jenisPerson => _jenisPerson;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["kode"] = _kode;
    map["namaKas"] = _namaKas;
    map["person"] = _person;
    map["noTelp"] = _noTelp;
    map["alamat"] = _alamat;
    map["jenisPerson"] = _jenisPerson;

    return map;
  }

  void setpersonId(int id) {
    this.id = id;
  }
}
