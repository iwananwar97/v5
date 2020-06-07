class Mytrans2 {
  String _katagori;

  Mytrans2(
    this._katagori,
  );

  Mytrans2.map(dynamic obj) {
    this._katagori = obj["katagori"];
  }

  String get katagori => _katagori;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["katagori"] = _katagori;

    return map;
  }
}
