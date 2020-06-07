class Mytrans5 {
  String _person;

  Mytrans5(
    this._person,
  );

  Mytrans5.map(dynamic obj) {
    this._person = obj["person"];
  }

  String get person => _person;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["person"] = _person;

    return map;
  }
}
