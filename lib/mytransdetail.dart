class Mytransdetail {
  String _rek;

  double _jumlah;

  String _createdate;
  String _updatedate;
  String _sortdate;

  Mytransdetail(
    this._rek,
    this._jumlah,
    this._createdate,
    this._updatedate,
    this._sortdate,
  );

  Mytransdetail.map(dynamic obj) {
    this._rek = obj["rek"];

    this._jumlah = obj["jumlah"];

    this._createdate = obj["createdate"];
    this._updatedate = obj["updatedate"];

    this._sortdate = obj["sortdate"];
  }

  String get rek => _rek;

  double get jumlah => _jumlah;

  String get createdate => _createdate;
  String get updatedate => _updatedate;

  String get sortdate => _sortdate;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["rek"] = _rek;

    map["jumlah"] = _jumlah;

    map["createdate"] = _createdate;
    map["updatedate"] = _updatedate;

    map["sortdate"] = _sortdate;

    return map;
  }

  // void setTransId(int id) {
  //   this.id = id;
  // }
}
