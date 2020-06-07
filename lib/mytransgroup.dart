class Mytransgroup {
  String _createdate;
  double _total;
  double _total1;

  Mytransgroup(
    this._createdate,
    this._total,
    this._total1,
  );

  Mytransgroup.map(dynamic obj) {
    this._createdate = obj["createdate"];
    this._total = obj["total"];
    this._total1 = obj["total1"];
  }

  String get createdate => _createdate;
  double get total => _total;
  double get total1 => _total1;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["total"] = _total;
    map["total1"] = _total1;

    return map;
  }
}
