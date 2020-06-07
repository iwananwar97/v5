class Mytransstatus3 {
  // int id;
  String _status;
  String _status3;
  // int _notransaksi;

  Mytransstatus3(
    this._status,
    this._status3,
    // this._notransaksi,
  );

  Mytransstatus3.map(dynamic obj) {
    this._status = obj["status"];
    this._status3 = obj["status3"];
    // this._notransaksi = obj["notransaksi"];
  }

  String get status => _status;
  String get status3 => _status3;
  // int get notransaksi => _notransaksi;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["status"] = _status;
    map["status3"] = _status3;
    // map["notransaksi"] = _notransaksi;

    return map;
  }

  // void setTransId(int id) {
  //   this.id = id;
  // }
}
