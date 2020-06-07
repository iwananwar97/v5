import 'dart:math';

import 'package:catatan_keuangan/custom/currency.dart';

import 'package:catatan_keuangan/mykatagori.dart';
import 'package:catatan_keuangan/myrutin.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

class AddRutinPage extends StatefulWidget {
  AddRutinPage(this._myrutin, this._isNew);

  final Myrutin _myrutin;
  final bool _isNew;

  _AddRutinPageState createState() => _AddRutinPageState();
}

class _AddRutinPageState extends State<AddRutinPage> {
  final formkey = new GlobalKey<FormState>();

  int min = 50;
  int max = 100;

  int notrans = Random().nextInt(1000000000);

  String tulis = '';

  var db = new TDBHelper();

  // int katagori;

  int indexradio1 = 1;
  int indexradio2 = 2;
  int indexradio3 = 1;
  int indexradio4 = 1;

  String title;
  String pp;
  bool BtnSave = false;
  bool BtnEdit = true;
  bool BtnDelete = true;
  bool Check = false;
  bool Status = false;

  var createDate;
  // var jatuhtempoDate;

  var cTgl = TextEditingController();
  var cDari = TextEditingController();
  var cJumlah = TextEditingController();
  var cKet = TextEditingController();

  DateTime _jtdate = DateTime.now();
  DateTime _currentdate = DateTime.now();
  var now = DateTime.now();
  var katagori = 'Belanja';
  var rek = '';
  var warning = '';

  var jenis = '';
  var tipe = '';
  var status = 'B';
  var status3 = '';
  var status5 = '';

  Myrutin myrutin;
  Mykatagori mykatagori;

  var notrans2;

  List<DropdownMenuItem> _listKategori = [];
  List<DropdownMenuItem> _listKategori2 = [];
  String _valueKategori;
  String _valueKategori2;

  Future addRecord() async {
    if (formkey.currentState.validate()) {
      var db = TDBHelper();
      String dateNow = "${now.day}${now.month}${now.year} ";

      String datePilih =
          "${_currentdate.day}-${_currentdate.month}-${_currentdate.year}";

      var rek = indexradio1 == 1 ? "dompet" : "bank";
      var jenis = indexradio2 == 1 ? "penerimaan" : "pengeluaran";
      var tipe = indexradio2 == 2 && indexradio3 == 1
          ? "non piutang"
          : indexradio2 == 2 && indexradio3 == 2
              ? "piutang"
              : indexradio2 == 1 && indexradio4 == 1
                  ? "non utang"
                  : indexradio2 == 1 && indexradio4 == 2 ? "utang" : "";
      // var status = indexradio2 == 2 && indexradio3 == 1
      //     ? "non piutang"
      //     : indexradio2 == 2 && indexradio3 == 2
      //         ? "piutang"
      //         : indexradio2 == 1 && indexradio4 == 1
      //             ? "non utang"
      //             : indexradio2 == 1 && indexradio4 == 2 ? "utang" : "";
      // int jumlah = int.parse(cJumlah.text);
      var myrutin = Myrutin(
        cDari.text,
        indexradio2 == 1 ? _valueKategori : _valueKategori2,
        rek,
        jenis,
        tipe,
        double.parse(cJumlah.text.replaceAll(".", "")),
        cKet.text,
        status,
        // datePilih,
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(_currentdate).toString(),
        // _currentdate.toString(),
        _currentdate.toString(),
        _jtdate.toString(),
        indexradio2 == 2 && indexradio3 == 1
            ? _currentdate.toString()
            : indexradio2 == 2 && indexradio3 == 2
                ? _jtdate.toString()
                : indexradio2 == 1 && indexradio4 == 1
                    ? _currentdate.toString()
                    : indexradio2 == 1 && indexradio4 == 2
                        ? _jtdate.toString()
                        : _currentdate.toString(),
        notrans.toString(),
        "Belum Lunas",
        "0",
        0,
        "Belum Lunas",
        "F",
        // _jtdate.toString(),
        // _jtdate.toString(),
      );

      await db.saveRutin(myrutin);

      print("saved");
      // print(mytrans.createdate);
      // print(_jtdate);
      // print(mytrans.katagori);
      // print(mytrans.sortdate);
      Navigator.of(context).pop();
    }
  }

  void updateRecord() async {
    if (formkey.currentState.validate()) {
      var db = new TDBHelper();
      String dateNow =
          "${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute} ";

      var rek = indexradio1 == 1 ? "dompet" : "bank";
      var jenis = indexradio2 == 1 ? "penerimaan" : "pengeluaran";
      var tipe = indexradio2 == 2 && indexradio3 == 1
          ? "non piutang"
          : indexradio2 == 2 && indexradio3 == 2
              ? "piutang"
              : indexradio2 == 1 && indexradio4 == 1
                  ? "non utang"
                  : indexradio2 == 1 && indexradio4 == 2 ? "utang" : "";
      var myrutin = new Myrutin(
        cDari.text,
        indexradio2 == 1 ? _valueKategori : _valueKategori2,
        rek,
        jenis,
        tipe,
        double.parse(cJumlah.text.replaceAll(".", "")),
        cKet.text,
        status,
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(_currentdate).toString(),
        // DateFormat(DateFormat.YEAR_MONTH_DAY)
        //     .format(jatuhtempodate)
        //     .toString(),
        _currentdate.toString(),
        _currentdate.toString(),
        _jtdate.toString(),
        notrans2,
        "Belum Lunas",
        "1",
        0,
        status3,
        "F",
      );

      myrutin.setRutinId(this.myrutin.id);
      await db.updateRutin(myrutin);
      // print(mytrans.jatuhtempodate);

      // if (mytrans.tipe == "non utang" || mytrans.tipe == "non piutang") {
      //   // _confirmdetele2();
      //   var mytransstatus = new Mytransstatus(
      //     "C",
      //   );
      //   await db.updateTransStatus(mytransstatus, notrans2);
      // }

      // if (mytrans.tipe == "utang") {
      //   if (mytrans.status3 == "Lunas") {
      //     var mytransstatus3 = new Mytransstatus3(
      //       "Lunas",
      //       "Lunas",
      //     );
      //     await db.updateTransStatuslunas(mytransstatus3, notrans2);
      //     var mytransstatus1 = new Mytransstatus(
      //       "C",
      //     );
      //     await db.updateTransStatus4(mytransstatus1, notrans2);
      //   } else {
      //     var mytransstatus = new Mytransstatus(
      //       "B",
      //     );
      //     await db.updateTransStatus2(mytransstatus, notrans2);
      //     var mytransstatus1 = new Mytransstatus(
      //       "C",
      //     );
      //     await db.updateTransStatus4(mytransstatus1, notrans2);
      //   }
      // } else if (mytrans.tipe == "piutang") {
      //   var mytransstatus = new Mytransstatus(
      //     "B",
      //   );
      //   await db.updateTransStatus5(mytransstatus, notrans2);
      //   var mytransstatus2 = new Mytransstatus(
      //     "C",
      //   );
      //   await db.updateTransStatus2(mytransstatus2, notrans2);
      // }
      // print(mytrans.jatuhtempodate);
      Navigator.of(context).pop();
      // print(_jtdate);
      // print(mytrans.katagori);

      print(myrutin.sortdate);
    }
  }

  void _saveData() {
    if (widget._isNew) {
      addRecord();
    } else {
      updateRecord();
    }
  }

  void _delete(Myrutin myrutin) {
    var db = new TDBHelper();
    db.deleteRutin(myrutin);
  }

  void _confirmDelete() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
        "Yakin Di Hapus  ???",
        style: TextStyle(fontSize: 16.0, color: Colors.red),
      ),
      actions: <Widget>[
        RaisedButton(
          color: Colors.red,
          child: Text("Ok Hapus", style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
            _delete(myrutin);
            Navigator.of(context).pop();
          },
        ),
        RaisedButton(
          color: Colors.yellow,
          child: Text("Cancel", style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  var status1;

  @override
  void initState() {
    if (widget._myrutin != null) {
      myrutin = widget._myrutin;
      cDari.text = myrutin.sumber;
      status1 = myrutin.status2;
      // _listKategori.first.value=myrutin.katagori;

      myrutin.jenis == "penerimaan"
          ? _valueKategori = myrutin.katagori
          : _valueKategori2 = myrutin.katagori;
      // katagori = myrutin.katagori;
      indexradio1 = myrutin.rek == "dompet" ? 1 : 2;
      indexradio2 = myrutin.jenis == "penerimaan" ? 1 : 2;
      indexradio3 =
          myrutin.tipe == "non piutang" || myrutin.tipe == "non utang" ? 1 : 2;
      indexradio4 =
          myrutin.tipe == "non utang" || myrutin.tipe == "non piutang" ? 1 : 2;
      cJumlah.text = myrutin.jumlah.toString();
      cKet.text = myrutin.ket;
      // createDate = myrutin.createdate;
      _currentdate = DateTime.parse(myrutin.updatedate);

      _jtdate = myrutin.tipe == "piutang" && myrutin.tipe == "utang"
          ? DateTime.parse(myrutin.sortdate)
          : DateTime.now();
      notrans2 = myrutin.notransaksi;
      status3 = myrutin.status3;
      status5 = myrutin.status;
      // _jtdate = DateTime.parse(mytrans.sortdate);
      // _currentdate = DateTime.parse(mytrans.sortdate);
      // String _formatedate = new DateFormat.yMMMd().format(sortdate);
      // title = "My Note";
      // print(mytrans.birthdate);
      // print(mytrans.katagori);
      // print(mytrans.updatedate);
      // print(mytrans.sortdate);
    }
    getKategori();
    getKategori2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<Null> _selectdate(BuildContext context) async {
      final DateTime _seldate = await showDatePicker(
        context: context,
        initialDate: _currentdate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2050),
      );

      if (_seldate != null) {
        setState(() {
          _currentdate = _seldate;
        });
      }
    }

    Future<Null> _selectjtdate(BuildContext context) async {
      final DateTime _seljtdate = await showDatePicker(
        context: context,
        initialDate: _jtdate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2050),
      );

      if (_seljtdate != null) {
        setState(() {
          _jtdate = _seljtdate;
        });
      }
    }

    if (widget._isNew) {
      title = "Tambah Transaksi";
      pp = "false";
      Status = true;

      BtnSave = false;
      BtnEdit = false;
    } else {
      if (status1 == "Bayar Utang" && status3 == "Belum Lunas") {
        title = "Edit Transaksi";
        warning =
            "Silahkan Edit Di Halaman Tagihan Utang Selama Utangnya Belum Lunas";
        BtnSave = false;
        Status = false;
        BtnEdit = true;
      } else if (status1 == "Bayar Utang" && status5 == "Lunas") {
        title = "Edit Transaksi";
        warning = "Tagihan Utang Sudah Lunas!! Tidak Bisa Diedit";
        BtnSave = false;
        Status = false;
        BtnEdit = true;
      } else if (status1 == "Bayar Piutang") {
        title = "Edit Transaksi";
        warning =
            "Silahkan Edit Di Halaman Tagihan Piutang Selama Piutangnya Belum Lunas";
        BtnSave = false;
        Status = false;
        BtnEdit = true;
      } else if (status1 == "Belum Lunas" && status3 == "Lunas") {
        title = "Edit Transaksi";
        warning = "Utang Sudah Lunas, Data Tidak Bisa Diedit";
        BtnSave = true;
        Status = false;
        BtnEdit = true;
      } else {
        title = "Edit Transaksi";
        BtnSave = true;
        Status = true;
        BtnEdit = false;

        pp = "true";
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,

                    // padding: const EdgeInsets.only(left: 0),
                    child: RaisedButton(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.grey[300],

                      // child: Text("Tanggal : $_formatedate"),
                      child: Text(
                        DateFormat(DateFormat.YEAR_MONTH_DAY)
                            .format(_currentdate)
                            .toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _selectdate(context);
                      },
                    ),
                  ),
                  Visibility(
                    child: Center(
                      child: RaisedButton(
                        color: Colors.white,
                        elevation: 0.0,
                        child: Text(
                          warning,
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    visible: BtnEdit,
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Text("KAS :",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: 156,
                              height: 40,
                              child: FlatButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    indexradio1 = 1;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Radio(
                                        value: 1,
                                        groupValue: indexradio1,
                                        onChanged: (n) {
                                          setState(() {
                                            indexradio1 = n;
                                          });
                                        },
                                      ),
                                    ),
                                    Text("KAS DOMPET")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 40,
                            child: FlatButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  indexradio1 = 2;
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Radio(
                                      value: 2,
                                      groupValue: indexradio1,
                                      onChanged: (n) {
                                        setState(() {
                                          indexradio1 = n;
                                        });
                                      },
                                    ),
                                  ),
                                  Text("KAS BANK")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Text(" ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              width: 161,
                              height: 40,
                              child: FlatButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    indexradio2 = 1;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Radio(
                                        value: 1,
                                        groupValue: indexradio2,
                                        onChanged: (n) {
                                          setState(() {
                                            indexradio2 = n;
                                          });
                                        },
                                      ),
                                    ),
                                    Text("PENERIMAAN")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 167,
                            height: 40,
                            child: FlatButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  indexradio2 = 2;
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Radio(
                                      value: 2,
                                      groupValue: indexradio2,
                                      onChanged: (n) {
                                        setState(() {
                                          indexradio2 = n;
                                        });
                                      },
                                    ),
                                  ),
                                  Text("PENGELUARAN")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Divider(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Kategori : ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      katagori1(),
                      // katagori2(),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  sumber(),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      // hintText: "Masukkan Angka",

                      labelText: "Nominal",
                      prefix: prefix0.Text(
                        "Rp. ",
                        style: prefix0.TextStyle(
                            fontSize: 14.0,
                            fontWeight: prefix0.FontWeight.bold),
                      ),

                      // contentPadding:
                      //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      hintStyle: TextStyle(fontSize: 12),
                    ),
                    keyboardType: TextInputType.number,
                    controller: cJumlah,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      Currencyformat()
                    ],
                    validator: (val) =>
                        val.isEmpty ? " Masukan Nominal Nyahhh!!" : null,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      hintText: "optional",
                      labelText: "Keterangan",
                      prefix: prefix0.Text(
                        "Ket :",
                        style: prefix0.TextStyle(
                            fontSize: 14.0,
                            fontWeight: prefix0.FontWeight.bold),
                      ),

                      // contentPadding:
                      //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      // hintStyle: TextStyle(fontSize: 12),
                    ),
                    keyboardType: TextInputType.text,
                    controller: cKet,
                    maxLines: 3,
                    textInputAction: TextInputAction.newline,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  bentuk(),
                  (indexradio2 == 1 && indexradio4 == 2) ||
                          (indexradio2 == 2 && indexradio3 == 2)
                      ? Row(
                          children: <Widget>[
                            Text("Jatuh Tempo :"),
                            SizedBox(
                              // width: MediaQuery.of(context).size.width,

                              // padding: const EdgeInsets.only(left: 0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  color: Colors.grey[300],

                                  // child: Text("Tanggal : $_formatedate"),
                                  child: Text(
                                    DateFormat(DateFormat.YEAR_MONTH_DAY)
                                        .format(_jtdate)
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.red),
                                  ),
                                  onPressed: () {
                                    _selectjtdate(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Visibility(
                          child: RaisedButton(
                            // onPressed: () {},
                            onPressed: () {
                              _saveData();
                            },

                            child: Text(
                              "Simpan",
                            ),
                            color: Colors.blue,
                          ),
                          visible: Status,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Visibility(
                        child: RaisedButton(
                          onPressed: () {
                            _confirmDelete();
                          },
                          child: Text("Delete"),
                          color: Colors.red,
                        ),
                        visible: BtnSave,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },

                        child: Text("Batal"),
                        color: Colors.yellow,
                        // visible = BtnSave,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )); // );
  }

  Widget katagori1() {
    if (indexradio2 == 1) {
      return _listKategori.length > 0
          ? DropdownButton(
              items: _listKategori,
              // isExpanded: true,
              value: _valueKategori ?? _listKategori.first.value,
              onChanged: (val) {
                _valueKategori = val;

                setState(() {});
              },
            )
          : Container();
    } else {
      return _listKategori2.length > 0
          ? DropdownButton(
              items: _listKategori2,
              // isExpanded: true,
              value: _valueKategori2 ?? _listKategori2.first.value,
              onChanged: (val) {
                _valueKategori2 = val;
                setState(() {});
              },
            )
          : Container();
    }
  }

  Widget sumber() {
    if (indexradio2 == 1) {
      return TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
          // hintText: "Masukan Nama atau Toko",
          labelText: "Sumber Penerimaan",
          prefix: prefix0.Text(
            "Dari :",
            style: prefix0.TextStyle(
                fontSize: 14.0, fontWeight: prefix0.FontWeight.bold),
          ),

          // contentPadding:
          //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          // hintStyle: TextStyle(fontSize: 12),
        ),
        keyboardType: TextInputType.text,
        controller: cDari,
        validator: (val) => val.isEmpty ? " Masukan Sumber Penerimaan" : null,
      );
    } else {
      return TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
          // hintText: "Masukan Nama atau Toko",
          labelText: "Tujuan Pengeluaran",
          prefix: prefix0.Text(
            "Untuk :",
            style: prefix0.TextStyle(
                fontSize: 14.0, fontWeight: prefix0.FontWeight.bold),
          ),

          // contentPadding:
          //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          // hintStyle: TextStyle(fontSize: 12),
        ),
        keyboardType: TextInputType.text,
        controller: cDari,
        validator: (val) => val.isEmpty ? " Masukan Tujuan Pengeluaran" : null,
      );
    }
  }

  Widget bentuk() {
    if (indexradio2 == 2) {
      return Row(
        children: <Widget>[
          Text("BENTUK :",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: 140,
              height: 40,
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  setState(() {
                    indexradio3 = 1;
                  });
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Radio(
                        value: 1,
                        groupValue: indexradio3,
                        onChanged: (n) {
                          setState(() {
                            indexradio3 = n;
                          });
                        },
                      ),
                    ),
                    Text("NON PIUTANG")
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 140,
            height: 40,
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  indexradio3 = 2;
                });
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Radio(
                      value: 2,
                      groupValue: indexradio3,
                      onChanged: (n) {
                        setState(() {
                          indexradio3 = n;
                        });
                      },
                    ),
                  ),
                  Text("PIUTANG")
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Text("BENTUK :",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: 140,
              height: 40,
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  setState(() {
                    indexradio4 = 1;
                  });
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Radio(
                        value: 1,
                        groupValue: indexradio4,
                        onChanged: (n) {
                          setState(() {
                            indexradio4 = n;
                          });
                        },
                      ),
                    ),
                    Text("NON UTANG")
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 140,
            height: 40,
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  indexradio4 = 2;
                });
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Radio(
                      value: 2,
                      groupValue: indexradio4,
                      onChanged: (n) {
                        setState(() {
                          indexradio4 = n;
                        });
                      },
                    ),
                  ),
                  Text("UTANG")
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

  void getKategori() async {
    // Katagori dbKategori = await Katagori.initDatabase();
    //  var katagor ='';
    // katagor = indexradio2==1?"await db.getKatagoriPenerimaan()":"getKatagoriPengeluaran";
    List<Mykatagori> tempKategori = await db.getKatagoriPenerimaan();
    for (Mykatagori item in tempKategori) {
      _listKategori.add(DropdownMenuItem(
        child: Container(
          height: 200.0,
          child: Row(
            children: <Widget>[
              // CircleAvatar(
              //   backgroundColor: Theme.of(context).primaryColor,
              //   child: Icon(item.icon, color: Colors.white),
              // ),
              // SizedBox(
              //   width: 10.0,
              // ),
              Text(item.nama)
            ],
          ),
        ),
        value: item.nama,
      ));
    }

    if (widget._isNew) {
      _valueKategori = _listKategori.first.value;
      setState(() {});
    } else {
      _valueKategori =
          indexradio2 == 1 ? myrutin.katagori : _listKategori.first.value;
      setState(() {});
    }

    // _valueKategori = _listKategori.first.value;
    // setState(() {});
  }

  void getKategori2() async {
    // Katagori dbKategori = await Katagori.initDatabase();
    //  var katagor ='';
    // katagor = indexradio2==1?"await db.getKatagoriPenerimaan()":"getKatagoriPengeluaran";
    List<Mykatagori> tempKategori = await db.getKatagoriPengeluaran();
    for (Mykatagori item in tempKategori) {
      _listKategori2.add(DropdownMenuItem(
        child: Container(
          height: 200.0,
          child: Row(
            children: <Widget>[
              // CircleAvatar(
              //   backgroundColor: Theme.of(context).primaryColor,
              //   child: Icon(item.icon, color: Colors.white),
              // ),
              // SizedBox(
              //   width: 10.0,
              // ),
              Text(item.nama)
            ],
          ),
        ),
        value: item.nama,
      ));
    }

    if (widget._isNew) {
      _valueKategori2 = _listKategori2.first.value;
      setState(() {});
    } else {
      if (myrutin.katagori == null) {}
      _valueKategori2 =
          indexradio2 == 2 ? myrutin.katagori : _listKategori2.first.value;
      setState(() {});
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getKategori();
  // }
}

Mykatagori mykatagori;

List<DropdownMenuItem<int>> dataKategori() {
  // var db = new TDBHelper();

  var data = List<DropdownMenuItem<int>>();

  data.add(DropdownMenuItem(
    value: 1,
    child: Text("Makan"),
  ));
  data.add(DropdownMenuItem(
    value: 2,
    child: Text("Belanja"),
  ));
  data.add(DropdownMenuItem(
    value: 3,
    child: Text("Gaji Utama"),
  ));
  return data;
}
