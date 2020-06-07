class Myutangpiutang {
  int id;
  String _sumber;
  String _katagori;
  String _rek;
  String _jenis;
  String _tipe;
  double _jumlah;
  String _ket;
  String _status;
  String _createdate;
  String _updatedate;
  String _birthdate;
  String _sortdate;
  int _idtransaksi;

  Myutangpiutang(
      this._sumber,
      this._katagori,
      this._rek,
      this._jenis,
      this._tipe,
      this._jumlah,
      this._ket,
      this._status,
      this._createdate,
      this._updatedate,
      this._birthdate,
      this._sortdate,
      this._idtransaksi);

  Myutangpiutang.map(dynamic obj) {
    this._sumber = obj["sumber"];
    this._katagori = obj["katagori"];
    this._rek = obj["rek"];
    this._jenis = obj["jenis"];
    this._tipe = obj["tipe"];
    this._jumlah = obj["jumlah"];
    this._ket = obj["ket"];
    this._status = obj["status"];
    this._createdate = obj["createdate"];
    this._updatedate = obj["updatedate"];
    this._birthdate = obj["birthdate"];
    this._sortdate = obj["sortdate"];
    this._idtransaksi = obj["idtransaksi"];
  }

  String get sumber => _sumber;
  String get katagori => _katagori;
  String get rek => _rek;
  String get jenis => _jenis;
  String get tipe => _tipe;
  double get jumlah => _jumlah;
  String get ket => _ket;
  String get status => _status;
  String get createdate => _createdate;
  String get updatedate => _updatedate;
  String get birthdate => _birthdate;
  String get sortdate => _sortdate;
  int get idtransaksi => _idtransaksi;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["sumber"] = _sumber;
    map["katagori"] = _katagori;
    map["rek"] = _rek;
    map["jenis"] = _jenis;
    map["tipe"] = _tipe;
    map["jumlah"] = _jumlah;
    map["ket"] = _ket;
    map["status"] = _status;
    map["createdate"] = _createdate;
    map["updatedate"] = _updatedate;
    map["birthdate"] = _birthdate;
    map["sortdate"] = _sortdate;
    map["idtransaksi"] = _idtransaksi;

    return map;
  }

  void setUtangPiutangId(int id) {
    this.id = id;
  }
}
