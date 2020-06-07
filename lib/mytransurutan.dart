class Mytransurutan {
  // int id;
  int _urutanbayar;
  // int _notransaksi;

  Mytransurutan(
    this._urutanbayar,
    // this._notransaksi,
  );

  Mytransurutan.map(dynamic obj) {
    this._urutanbayar = obj["urutanbayar"];
    // this._notransaksi = obj["notransaksi"];
  }

  int get urutanbayar => _urutanbayar;
  // int get notransaksi => _notransaksi;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["urutanbayar"] = _urutanbayar;
    // map["notransaksi"] = _notransaksi;

    return map;
  }

  // void setTransId(int id) {
  //   this.id = id;
  // }
}
