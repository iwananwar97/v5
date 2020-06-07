class Mytransstatus {
  // int id;
  String _status;
  // int _notransaksi;

  Mytransstatus(
    this._status,
    // this._notransaksi,
  );

  Mytransstatus.map(dynamic obj) {
    this._status = obj["status"];
    // this._notransaksi = obj["notransaksi"];
  }

  String get status => _status;
  // int get notransaksi => _notransaksi;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["status"] = _status;
    // map["notransaksi"] = _notransaksi;

    return map;
  }

  // void setTransId(int id) {
  //   this.id = id;
  // }
}
