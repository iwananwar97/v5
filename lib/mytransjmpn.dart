class Mytransjmpn {
  String _total;

  Mytransjmpn(
    this._total,
  );

  Mytransjmpn.map(dynamic obj) {
    this._total = obj["total"];
  }

  String get total => _total;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["total"] = _total;

    return map;
  }
}
