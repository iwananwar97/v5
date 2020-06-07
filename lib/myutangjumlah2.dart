class Myutangjumlah2 {
  int id;
  String _sumber;
  String _katagori;
  String _kas;
  String _kas1;
  String _tipekas;
  String _person;
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
  String _notransaksi;
  String _status2;
  String _notrans;
  int _urutanbayar;
  double _total;

  Myutangjumlah2(
    this._sumber,
    this._katagori,
    this._kas,
    this._kas1,
    this._tipekas,
    this._person,
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
    this._notransaksi,
    this._status2,
    this._notrans,
    this._urutanbayar,
    this._total,
  );

  Myutangjumlah2.map(dynamic obj) {
    this._sumber = obj["sumber"];
    this._katagori = obj["katagori"];
    this._kas = obj["kas"];
    this._kas1 = obj["kas1"];
    this._tipekas = obj["tipekas"];
    this._person = obj["person"];
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
    this._notransaksi = obj["notransaksi"];
    this._status2 = obj["status2"];
    this._notrans = obj["notrans"];
    this._urutanbayar = obj["urutanbayar"];
    this._total = obj["total"];
  }

  String get sumber => _sumber;
  String get katagori => _katagori;
  String get kas => _kas;
  String get kas1 => _kas1;
  String get tipekas => _tipekas;
  String get person => _person;
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
  String get notransaksi => _notransaksi;
  String get status2 => _status2;
  String get notrans => _notrans;
  int get urutanbayar => _urutanbayar;
  double get total => _total;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["sumber"] = _sumber;
    map["katagori"] = _katagori;
    map["kas"] = _kas;
    map["kas1"] = _kas1;
    map["tipekas"] = _tipekas;
    map["person"] = _person;
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
    map["notransaksi"] = _notransaksi;
    map["status2"] = _status2;
    map["notrans"] = _notrans;
    map["urutanbayar"] = _urutanbayar;
    map["total"] = _total;

    return map;
  }

  void setTransId(int id) {
    this.id = id;
  }
}
