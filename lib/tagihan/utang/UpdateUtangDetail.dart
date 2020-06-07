import 'dart:math';

import 'package:catatan_keuangan/custom/currency.dart';

import 'package:catatan_keuangan/mykatagori.dart';
import 'package:catatan_keuangan/mytransdetail.dart';

import 'package:catatan_keuangan/mytransstatus.dart';
import 'package:catatan_keuangan/mytransstatus3.dart';
import 'package:catatan_keuangan/mytransurutan.dart';
import 'package:catatan_keuangan/mytransutang.dart';
import 'package:catatan_keuangan/mytransutangbelumlunas.dart';
import 'package:catatan_keuangan/myutangjumlah.dart';
import 'package:catatan_keuangan/myutangjumlah2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

import 'package:catatan_keuangan/mytrans.dart';
import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

class UpdateUtangDetail extends StatefulWidget {
  UpdateUtangDetail(this._mytransutangbelumlunas, this._isNew);

  final Mytransutangbelumlunas _mytransutangbelumlunas;

  final bool _isNew;

  _UpdateUtangDetailState createState() => _UpdateUtangDetailState();
}

class _UpdateUtangDetailState extends State<UpdateUtangDetail> {
  final formkey = new GlobalKey<FormState>();
  var f = NumberFormat(
    "#,###",
  );

  String tulis = '';
  int notrans3 = Random().nextInt(1000000000);

  var db = new TDBHelper();

  int indexradio1 = 1;
  int indexradio2 = 1;

  String title;
  String pp;
  bool BtnSave = false;
  bool BtnEdit = true;
  bool BtnDelete = true;
  bool Check = false;

  var info;

  var createDate;
  // var jatuhtempoDate;

  var cTgl = TextEditingController();
  var cDari = TextEditingController();
  var cJumlah = TextEditingController();
  var cKet = TextEditingController();
  var cKet2 = TextEditingController();
  var cBayarFull = TextEditingController();
  var cBayarSebagian = TextEditingController();

  int kategori = 1;
  int urutan;

  int urutan2;

  double jumlahutang, bayar1, sisautang3;

  DateTime _jtdate = DateTime.now();
  DateTime _currentdate = DateTime.now();
  var now = DateTime.now();
  var katagori;
  var rek = 'dompet';

  var jenis = 'tunai';
  var tipe = 'penerimaan';
  var status = 'C';
  var sisa2 = "";
  var notrans2;
  var notrans4;

  // int jumlah2 = int.parse(f.format(jumlah..replaceAll(",", "."));

  var kategori2 = "Bayar Utang";

  String sisa3;

  double jumlah;
  int sisafull;
  int sisasebagian;
  int id;
  double jumlah2;
  int jumlah1;
  double sisautang;
  int sisautang1;
  int sisautang2;
  double jumlahsisa;
  double total, sisa, jumlah5;

  var sumber2;
  var ket3;
  var rek2;
  String bayarlagi;
  // List<Myutangjumlah> [];

  Mykatagori mykatagori;
  // Mytrans mytrans;
  Mytransstatus mytransstatus;
  Mytransutang mytransutang;
  Myutangjumlah myutangjumlah;
  Mytransutangbelumlunas mytransutangbelumlunas;

  Future addRecord() async {
    if (formkey.currentState.validate()) {
      var db = TDBHelper();
      var mytransdetail = new Mytransdetail(
        indexradio2 == 1 ? "dompet" : "bank",
        double.parse(cBayarSebagian.text.replaceAll(".", "")),
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(_currentdate).toString(),
        _currentdate.toString(),
        _currentdate.toString(),
      );

      await db.updateDetailUtang(mytransdetail, notrans4);

      sisautang = double.parse(cBayarSebagian.text.replaceAll(".", ""));

      if (jumlah - sisautang == 0) {
        var mytransstatus3 = new Mytransstatus3(
          "Lunas",
          "Lunas",
        );
        await db.updateTransStatuslunas(mytransstatus3, notrans2);
      } else {
        var mytransstatus3 = new Mytransstatus3(
          "B",
          "A",
        );
        await db.updateTransStatuslunas(mytransstatus3, notrans2);
      }
    }
    Navigator.of(context).pop();
  }

  void updateRecord() async {
    if (formkey.currentState.validate()) {
      var db = new TDBHelper();
    }
  }

  void _saveData() {
    if (widget._isNew) {
      sisautang = double.parse(cBayarSebagian.text.replaceAll(".", ""));

      if (jumlah - sisautang < 0) {
        setState(() {
          info = "Jumlah Pembayaran Melebihi Jumlah Utang";
        });
      } else if (jumlah - sisautang == jumlah) {
        setState(() {
          info = "Jumlah Belum Diisi";
        });
      } else {
        addRecord();
      }
    } else {
      updateRecord();
    }
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
            // _delete(mytrans);
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

  @override
  void initState() {
    if (widget._mytransutangbelumlunas != null) {
      mytransutangbelumlunas = widget._mytransutangbelumlunas;
      katagori = "Bayar Utang";

      urutan = mytransutangbelumlunas.urutanbayar;
      id = mytransutangbelumlunas.id;

      jumlahutang = mytransutangbelumlunas.jumlah;

      sumber2 = mytransutangbelumlunas.sumber;
      ket3 = mytransutangbelumlunas.ket;
      cBayarSebagian.text =
          f.format(mytransutangbelumlunas.jumlah).replaceAll(",", ".");
      _currentdate = DateTime.parse(mytransutangbelumlunas.updatedate);

      notrans4 = mytransutangbelumlunas.notrans.toString();
      urutan2 = mytransutangbelumlunas.urutanbayar;
      notrans2 = mytransutangbelumlunas.notransaksi;
    }
    _getData(notrans2);
    super.initState();
  }

  void _getData(notrans2) async {
    List<Myutangjumlah> myutangjumlah = await db.getUtangJumlah(notrans2);
    for (int i = 0; i < myutangjumlah.length; i++) {
      setState(() {
        bayar1 = myutangjumlah[i].total1 != null ? myutangjumlah[i].total1 : 0;
        jumlahsisa =
            myutangjumlah[i].total != null ? myutangjumlah[i].total : 0;
      });
    }

    sisautang3 = jumlahutang + jumlahsisa - bayar1;
    sisa = jumlahsisa - bayar1;
    jumlah = sisautang3;
    jumlah5 = sisa;
    // cBayarFull.text = f.format(sisautang3).replaceAll(",", ".");

    // print(sisautang);
    // print(jumlah);
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

    if (widget._isNew) {
      title = "Pembayaran Utang";
      pp = "false";

      BtnSave = false;
      BtnEdit = false;
    } else {
      title = "Pembayaran Utang";
      BtnSave = true;
      pp = "true";
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
                  Text(""),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.grey[300],
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
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      jumlah5 != null
                          ? "Sisa Utang : Rp. ${f.format(sisa).replaceAll(",", ".")}"
                          : 0.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Bayar ke: ${mytransutangbelumlunas.urutanbayar}  Rp. ${f.format(mytransutangbelumlunas.jumlah).replaceAll(",", ".")}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      jumlah != null
                          ? "Total pelunasan : Rp. ${f.format(sisautang3).replaceAll(",", ".")}"
                          : 0.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                      child: Text(
                    "BAYAR DARI KAS :",
                    style: TextStyle(color: Colors.blue),
                  )),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
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
                                    indexradio2 = 1;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
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
                                  indexradio2 = 2;
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
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
                                  Text("KAS BANK")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    child: Divider(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  bayar(),
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
                              "Bayar",
                            ),
                            color: Colors.blue,
                          ),
                          visible: BtnDelete,
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

  Widget bayar() {
    return Container(
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: "Jumlah Bayar",
              labelText: "jumlah Bayar",
              prefix: prefix0.Text(
                "Rp : ",
                style: prefix0.TextStyle(
                    fontSize: 14.0, fontWeight: prefix0.FontWeight.bold),
              ),
            ),
            keyboardType: TextInputType.number,
            controller: cBayarSebagian,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              Currencyformat()
            ],
            validator: (val) =>
                val.isEmpty ? " Masukan Nominal Nyahhh!!" : null,
            onFieldSubmitted: (String str) {
              setState(() {
                sisa2 = str;
                if (str != "") {
                  sisa2 = str.replaceAll(".", "");
                } else {
                  sisa2 = "";
                }

                if (double.parse(sisa2) > jumlah) {
                  info = "Jumlah Melebihi Batas Pembayaran";
                  BtnDelete = false;
                  jumlah2 = null;
                } else {
                  info = "";
                  BtnDelete = true;
                  jumlah2 = jumlah - double.parse(sisa2);
                }
              });
            },
            textInputAction: TextInputAction.done,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      jumlah2 != null
                          ? "Sisa : Rp. ${f.format(jumlah2).replaceAll(",", ".")}"
                          : "",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${info}",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

List<DropdownMenuItem<int>> dataKategori() {
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
