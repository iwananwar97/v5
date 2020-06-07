class Mytrans4 {
  String _kas2;

  Mytrans4(
    this._kas2,
  );

  Mytrans4.map(dynamic obj) {
    this._kas2 = obj["kas2"];
  }

  String get kas2 => _kas2;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["kas2"] = _kas2;

    return map;
  }
}
