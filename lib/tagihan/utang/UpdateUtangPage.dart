import 'dart:math';

import 'package:catatan_keuangan/custom/currency.dart';

import 'package:catatan_keuangan/mykatagori.dart';

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

class UpdateUtangPage extends StatefulWidget {
  UpdateUtangPage(this._mytransutang, this._isNew);

  // final Mytrans _mytrans;
  // final List<Myutangjumlah>
  final Mytransutang _mytransutang;
  // final Myutangjumlah _myutangjumlah;

  final bool _isNew;

  _UpdateUtangPageState createState() => _UpdateUtangPageState();
}

class _UpdateUtangPageState extends State<UpdateUtangPage> {
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

  // int jumlah2 = int.parse(f.format(jumlah..replaceAll(",", "."));

  var kategori2 = "Bayar Utang";

  String sisa3;

  double jumlah;
  double sisafull;
  double sisasebagian;
  int id;
  double jumlah2;
  int jumlah1;
  int sisautang;
  int sisautang1;
  int sisautang2;
  double sisautang3;
  double bayar1;
  int total;
  double jumlahutang;

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

  Future addRecord() async {
    if (formkey.currentState.validate()) {
      var db = TDBHelper();
      var mytransutang = Mytransurutan(
        urutan + 1,
      );

      await db.updateUrutan(mytransutang, id);

      var jenis = "pengeluaran";
      var tipe = "non utang";

      var mytrans = new Mytrans(
        sumber2,
        kategori2,
        '',
        '',
        '',
        '',
        indexradio2 == 1 ? "dompet" : "bank",
        jenis,
        tipe,
        indexradio1 == 1
            ? double.parse(cBayarFull.text.replaceAll(".", ""))
            : double.parse(cBayarSebagian.text.replaceAll(".", "")),
        ket3,
        "B",
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(_currentdate).toString(),
        _currentdate.toString(),
        _currentdate.toString(),
        _currentdate.toString(),
        notrans2,
        "Bayar Utang",
        "A" + notrans3.toString(),
        urutan + 1,
        "Belum Lunas",
        "F",
      );

      // mytrans.setTransId(this.mytrans.id);
      await db.saveTransUtangBelumLunas(mytrans);
      var mytransutangbelumlunas = Mytransutangbelumlunas(
        sumber2,
        kategori2,
        '',
        '',
        '',
        '',
        indexradio2 == 1 ? "dompet" : "bank",
        jenis,
        "utang",
        indexradio1 == 1
            ? double.parse(cBayarFull.text.replaceAll(".", ""))
            : double.parse(cBayarSebagian.text.replaceAll(".", "")),
        ket3,
        "C",
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(_currentdate).toString(),
        _currentdate.toString(),
        _currentdate.toString(),
        _currentdate.toString(),
        notrans2.toString(),
        "A",
        "A" + notrans3.toString(),
        urutan + 1,
        "Belum Lunas",
        "F",
      );

      await db.saveTransUtangBelumLunas2(mytransutangbelumlunas);

      sisautang = int.parse(cBayarSebagian.text.replaceAll(".", ""));
      sisautang1 = int.parse(cBayarFull.text.replaceAll(".", ""));

      if (indexradio1 == 1) {
        var mytransstatus3 = new Mytransstatus3(
          "Lunas",
          "Lunas",
        );
        await db.updateTransStatuslunas(mytransstatus3, notrans2);
      } else {
        if (jumlah - sisautang == 0) {
          var mytransstatus3 = new Mytransstatus3(
            "Lunas",
            "Lunas",
          );
          await db.updateTransStatuslunas(mytransstatus3, notrans2);
        } else {
          var mytransstatus3 = new Mytransstatus3(
            "B",
            "Belum Lunas",
          );
          await db.updateTransStatuslunas(mytransstatus3, notrans2);
        }
      }
    }
    Navigator.of(context).pop();
  }

  void updateRecord() async {
    if (formkey.currentState.validate()) {
      var db = new TDBHelper();

      var mytrans = Mytrans(
        // sumber2,
        "nana",
        "d",
        "",
        "",
        "",
        "d",
        "d",
        "d",
        "d",
        1000,
        "1000",
        "1000",
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(_currentdate).toString(),
        _currentdate.toString(),
        _currentdate.toString(),
        _jtdate.toString(),
        notrans2,
        "A",
        "A" + notrans3.toString(),
        0,
        "A",
        "F",
      );

      await db.saveTransUtangBelumLunas(mytrans);

      Navigator.of(context).pop();
    }
  }

  void _saveData() {
    if (widget._isNew) {
      sisautang = int.parse(cBayarSebagian.text.replaceAll(".", ""));
      sisautang1 = int.parse(cBayarFull.text.replaceAll(".", ""));

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

  void _saveData2() {
    if (widget._isNew) {
      addRecord();
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
    if (widget._mytransutang != null) {
      mytransutang = widget._mytransutang;
      katagori = "Bayar Utang";
      urutan = mytransutang.urutanbayar;
      id = mytransutang.id;
      jumlahutang = mytransutang.jumlah;
      sumber2 = mytransutang.sumber;
      ket3 = mytransutang.ket;
      // cBayarFull.text = f.format(mytransutang.jumlah).replaceAll(",", ".");
      cBayarSebagian.text = 0.toString();
      notrans2 = mytransutang.notransaksi;
    }
    _getData(notrans2);
    super.initState();
  }

  // String nama4;

  // FutureBuilder()
  void _getData(notrans2) async {
    List<Myutangjumlah> myutangjumlah = await db.getUtangJumlah(notrans2);
    for (int i = 0; i < myutangjumlah.length; i++) {
      setState(() {
        bayar1 = myutangjumlah[i].total1 != null ? myutangjumlah[i].total1 : 0;
      });
    }

    sisautang3 = jumlahutang - bayar1;
    jumlah = sisautang3;
    cBayarFull.text = f.format(sisautang3).replaceAll(",", ".");

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
                      jumlah != null
                          ? "Sisa Utang : Rp. ${f.format(sisautang3).replaceAll(",", ".")}"
                          : 0.toString(),
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  // Center(
                  //   child: Text(
                  //     sisautang2 != null
                  //         ? "Utang : Rp. ${f.format(sisautang2).replaceAll(",", ".")}"
                  //         : 0.toString(),
                  //     style: TextStyle(
                  //       fontSize: 22,
                  //       color: Colors.red,
                  //     ),
                  //   ),
                  // ),
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
                                    Text("Bayar Semua")
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
                                  Text("Bayar Sebagian")
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
                              indexradio1 == 1 ? _saveData2() : _saveData();
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
    if (indexradio1 == 1) {
      return Container(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: "Bayar Semua",
                labelText: "Bayar Semua",
                prefix: prefix0.Text(
                  "Rp : ",
                  style: prefix0.TextStyle(
                      fontSize: 14.0, fontWeight: prefix0.FontWeight.bold),
                ),
              ),
              keyboardType: TextInputType.number,
              controller: cBayarFull,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                Currencyformat()
              ],
              // maxLines: 3,
              textInputAction: TextInputAction.newline,
              readOnly: true,
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sisa : Rp. 0",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: "Bayar Sebagian",
                labelText: "Bayar Sebagian",
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

                  if (int.parse(sisa2) > jumlah) {
                    info = "Jumlah Melebihi Batas Pembayaran";
                    BtnDelete = false;
                    jumlah2 = null;
                  } else {
                    info = "";
                    BtnDelete = true;
                    jumlah2 = jumlah - int.parse(sisa2);
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
