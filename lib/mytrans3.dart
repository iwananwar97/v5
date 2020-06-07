class Mytrans3 {
  String _kas;

  Mytrans3(
    this._kas,
  );

  Mytrans3.map(dynamic obj) {
    this._kas = obj["kas"];
  }

  String get kas => _kas;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["kas"] = _kas;

    return map;
  }
}
