import 'dart:math';

import 'package:catatan_keuangan/custom/currency.dart';
import 'package:catatan_keuangan/mykas.dart';

import 'package:catatan_keuangan/mykatagori.dart';
import 'package:catatan_keuangan/myperson.dart';
import 'package:catatan_keuangan/mytransstatus.dart';
import 'package:catatan_keuangan/mytransstatus3.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

import 'package:catatan_keuangan/mytrans.dart';
import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class AddTransaksiPage extends StatefulWidget {
  AddTransaksiPage(this._mytrans, this._isNew);

  final Mytrans _mytrans;
  final bool _isNew;

  _AddTransaksiPageState createState() => _AddTransaksiPageState();
}

class _AddTransaksiPageState extends State<AddTransaksiPage> {
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
  int indexradio5 = 1;
  int indexradio6 = 1;

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
  var kas1 = '';
  var kas2 = '';
  var kas5 = '';
  var kas6 = '';
  var kas7 = '';
  var kas8 = '';
  var person1 = '';
  var person2 = '';
  var person5 = '';
  var person6 = '';
  var kategori = '';
  var st = 'tidak';

  Mytrans mytrans;
  Mykatagori mykatagori;
  Myperson myperson;
  Mykas mykas;

  var notrans2;

  List<DropdownMenuItem> _listKategori = [];
  List<DropdownMenuItem> _listKategori2 = [];
  List<DropdownMenuItem> _listKas1 = [];
  List<DropdownMenuItem> _listKas2 = [];
  List<DropdownMenuItem> _listPerson1 = [];
  List<DropdownMenuItem> _listPerson2 = [];
  String _valueKategori;
  String _valueKategori2;
  String _valueKas1;
  String _valueKas2;
  String _valuePerson1;
  String _valuePerson2;

  Future addRecord() async {
    if (formkey.currentState.validate()) {
      var db = TDBHelper();
      String dateNow = "${now.day}${now.month}${now.year} ";

      String datePilih =
          "${_currentdate.day}-${_currentdate.month}-${_currentdate.year}";

      var rek = _valueKas1;
      var jenis = indexradio2 == 1 ? "penerimaan" : "pengeluaran";
      var tipe = indexradio2 == 2 && indexradio3 == 1
          ? "non piutang"
          : indexradio2 == 2 && indexradio3 == 2
              ? "piutang"
              : indexradio2 == 1 && indexradio4 == 1
                  ? "non utang"
                  : indexradio2 == 1 && indexradio4 == 2 ? "utang" : "";

      var sumber = indexradio5 == 1
          ? cDari.text
          : indexradio5 == 2
              ? _valuePerson1
              : indexradio5 == 3 ? _valueKas2 : "";

      var kas1 = indexradio5 == 1
          ? cDari.text
          : indexradio5 == 2
              ? _valuePerson1
              : indexradio5 == 3 ? _valueKas2 : "";

      var tipekas = indexradio5 == 1
          ? 'umum'
          : indexradio5 == 2 ? 'list' : indexradio5 == 3 ? 'kas' : "";
      // var status = indexradio2 == 2 && indexradio3 == 1
      //     ? "non piutang"
      //     : indexradio2 == 2 && indexradio3 == 2
      //         ? "piutang"
      //         : indexradio2 == 1 && indexradio4 == 1
      //             ? "non utang"
      //             : indexradio2 == 1 && indexradio4 == 2 ? "utang" : "";
      // int jumlah = int.parse(cJumlah.text);
      var mytrans = Mytrans(
        sumber,
        indexradio2 == 1 ? _valueKategori : _valueKategori2,
        _valueKas1,
        kas1,
        tipekas,
        _valuePerson1,
        rek,
        jenis,
        tipe,
        // cJumlah.text,
        // int.parse(cJumlah.text),
        double.parse(cJumlah.text.replaceAll(",", "")),
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

      await db.saveTrans(mytrans);

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

      var rek = _valueKas1;
      var jenis = indexradio2 == 1 ? "penerimaan" : "pengeluaran";
      var tipe = indexradio2 == 2 && indexradio3 == 1
          ? "non piutang"
          : indexradio2 == 2 && indexradio3 == 2
              ? "piutang"
              : indexradio2 == 1 && indexradio4 == 1
                  ? "non utang"
                  : indexradio2 == 1 && indexradio4 == 2 ? "utang" : "";

      var sumber = indexradio5 == 1
          ? cDari.text
          : indexradio5 == 2
              ? _valuePerson1
              : indexradio5 == 3 ? _valueKas2 : "";

      var kas1 = indexradio5 == 1
          ? cDari.text
          : indexradio5 == 2
              ? _valuePerson1
              : indexradio5 == 3 ? _valueKas2 : "";

      var tipekas = indexradio5 == 1
          ? "umum"
          : indexradio5 == 2 ? "list" : indexradio5 == 3 ? "kas" : "";
      var mytrans = new Mytrans(
        sumber,
        indexradio2 == 1 ? _valueKategori : _valueKategori2,
        _valueKas1,
        kas1,
        tipekas,
        _valuePerson1,
        rek,
        jenis,
        tipe,
        double.parse(cJumlah.text.replaceAll(",", "")),
        // int.parse(cJumlah.text.replaceAll(".", "")),
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

      mytrans.setTransId(this.mytrans.id);
      await db.updateTrans(mytrans);
      // print(mytrans.jatuhtempodate);

      if (mytrans.tipe == "non utang" || mytrans.tipe == "non piutang") {
        // _confirmdetele2();
        var mytransstatus = new Mytransstatus(
          "C",
        );
        await db.updateTransStatus(mytransstatus, notrans2);
      }

      if (mytrans.tipe == "utang") {
        if (mytrans.status3 == "Lunas") {
          var mytransstatus3 = new Mytransstatus3(
            "Lunas",
            "Lunas",
          );
          await db.updateTransStatuslunas(mytransstatus3, notrans2);
          var mytransstatus1 = new Mytransstatus(
            "C",
          );
          await db.updateTransStatus4(mytransstatus1, notrans2);
        } else {
          var mytransstatus = new Mytransstatus(
            "B",
          );
          await db.updateTransStatus2(mytransstatus, notrans2);
          var mytransstatus1 = new Mytransstatus(
            "C",
          );
          await db.updateTransStatus4(mytransstatus1, notrans2);
        }
      } else if (mytrans.tipe == "piutang") {
        var mytransstatus = new Mytransstatus(
          "B",
        );
        await db.updateTransStatus5(mytransstatus, notrans2);
        var mytransstatus2 = new Mytransstatus(
          "C",
        );
        await db.updateTransStatus2(mytransstatus2, notrans2);
      }
      // print(mytrans.jatuhtempodate);
      Navigator.of(context).pop();
      // print(_jtdate);
      // print(mytrans.katagori);

      print(mytrans.sortdate);
    }
  }

  void _saveData() {
    if (widget._isNew) {
      addRecord();
      print(_valueKas1);
    } else {
      updateRecord();
    }
  }

  void _status() {
    if (widget._isNew) {
      // addRecord();
      print(_valueKas1);
    } else {
      // updateRecord();
    }
  }

  void _delete(Mytrans mytrans) {
    var db = new TDBHelper();
    db.deleteTrans(mytrans);
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
            _delete(mytrans);
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
    if (widget._mytrans != null) {
      mytrans = widget._mytrans;
      cDari.text = mytrans.sumber;
      kategori = mytrans.katagori;
      status1 = mytrans.status2;
      // _listKategori.first.value=mytrans.katagori;

      _valueKas1 = mytrans.kas;
      _valueKas2 = mytrans.kas1;
      _valuePerson1 = mytrans.sumber;

      // print(_valuePerson1);

      mytrans.jenis == "penerimaan"
          ? _valueKategori = mytrans.katagori
          : _valueKategori2 = mytrans.katagori;
      // katagori = mytrans.katagori;
      indexradio1 = mytrans.rek == "dompet" ? 1 : 2;
      indexradio2 = mytrans.jenis == "penerimaan" ? 1 : 2;
      indexradio5 = mytrans.tipekas == "umum"
          ? 1
          : mytrans.tipekas == "list" ? 2 : mytrans.tipekas == "kas" ? 3 : 0;
      indexradio4 = indexradio3 =
          mytrans.tipe == "non piutang" || mytrans.tipe == "non utang" ? 1 : 2;
      indexradio4 =
          mytrans.tipe == "non utang" || mytrans.tipe == "non piutang" ? 1 : 2;
      cJumlah.text = mytrans.jumlah.toString();
      cKet.text = mytrans.ket;
      // createDate = mytrans.createdate;
      _currentdate = DateTime.parse(mytrans.updatedate);

      _jtdate = mytrans.tipe == "piutang" && mytrans.tipe == "utang"
          ? DateTime.parse(mytrans.sortdate)
          : DateTime.now();
      notrans2 = mytrans.notransaksi;
      status3 = mytrans.status3;
      status5 = mytrans.status;
      kas5 = mytrans.kas;
      kas6 = mytrans.kas1;
      person5 = mytrans.sumber;
      // print(mytrans.tipekas);
      // print(mytrans.sumber);
      // print(person5);
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
    getKas1();
    getKas2();
    // getPerson1('tidak');
    // getPerson2();
    // print(_valueKas1);
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
      kas5 = _valueKas1;

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
                          Text(" ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: 161,
                              height: 30,
                              child: FlatButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  setState(() {
                                    indexradio2 = 1;
                                    // getPerson1('ada');
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
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
                            height: 30,
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
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Radio(
                                      value: 2,
                                      groupValue: indexradio2,
                                      onChanged: (n) {
                                        setState(() {
                                          indexradio2 = n;
                                          // getPerson1('ada');
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
                    height: 5.0,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Kas  ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 36,
                      ),
                      Text(
                        " : ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      kas(),
                      // katagori2(),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Kategori  ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        " : ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      katagori1(),
                      // katagori2(),
                    ],
                  ),
                  // Text('$kas5'),
                  SizedBox(
                    height: 5.0,
                  ),

                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(indexradio2 == 1 ? "Sumber :" : "Tujuan",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 95,
                          height: 30,
                          child: FlatButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                indexradio5 = 1;
                                // print(_valueKas1);
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Radio(
                                    value: 1,
                                    groupValue: indexradio5,
                                    onChanged: (n) {
                                      setState(() {
                                        indexradio5 = n;
                                      });
                                    },
                                  ),
                                ),
                                Text("Umum")
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 75,
                        height: 40,
                        child: FlatButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              indexradio5 = 2;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Radio(
                                  value: 2,
                                  groupValue: indexradio5,
                                  onChanged: (n) {
                                    setState(() {
                                      indexradio5 = n;
                                      // st = 'ada';
                                      // // kas5 = '';
                                      // kas5 = _valueKas1;
                                      // print(st);
                                      // print(kas5);
                                      getPerson1('ada');
                                      // get
                                      // if (indexradio2 == 1) {
                                      //   getPerson1('ada');
                                      // } else {
                                      //   getPerson2('ada');
                                      // }
                                    });
                                  },
                                ),
                              ),
                              Text("List")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 75,
                        height: 40,
                        child: FlatButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              indexradio5 = 3;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Radio(
                                  value: 3,
                                  groupValue: indexradio5,
                                  onChanged: (n) {
                                    setState(() {
                                      indexradio5 = n;
                                    });
                                  },
                                ),
                              ),
                              Text("Kas")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // sumberUtama(),
                  sumber1(),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 88.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(10.0)),
                        hintText: "Masukkan Angka",

                        // labelText: "Nominal",
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
                        ThousandsFormatter(allowFraction: true)
                      ],
                      // inputFormatters: [
                      //   WhitelistingTextInputFormatter.digitsOnly,
                      //   Currencyformat()
                      // ],
                      validator: (val) =>
                          val.isEmpty ? " Masukan Nominal Nyahhh!!" : null,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 88.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(10.0)),
                        hintText: "Keterangan",
                        // labelText: "Keterangan",
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
                      // maxLines: 3,
                      textInputAction: TextInputAction.newline,
                    ),
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

  Widget sumber1() {
    // if (indexradio2 == 1) {
    if (indexradio5 == 1) {
      return Padding(
        padding: const EdgeInsets.only(left: 88.0),
        child: TextFormField(
          decoration: InputDecoration(
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
            hintText:
                indexradio2 == 1 ? "Sumber Penerimaan" : "Tujuan Pengeluaran",
            // labelText: "Sumber Penerimaan",
            prefix: prefix0.Text(
              indexradio2 == 1 ? "Dari :" : "Untuk :",
              style: prefix0.TextStyle(
                  fontSize: 14.0, fontWeight: prefix0.FontWeight.bold),
            ),

            // contentPadding:
            //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            // hintStyle: TextStyle(fontSize: 12),
          ),
          keyboardType: TextInputType.text,
          controller: cDari,
          validator: (val) => val.isEmpty
              ? indexradio2 == 1
                  ? " Masukan Sumber Penerimaan"
                  : "Masukan Tujuan Pengeluaran"
              : null,
        ),
      );
      // person7();

    } else if (indexradio5 == 2) {
      if (indexradio2 == 1) {
        return Padding(
          padding: const EdgeInsets.only(left: 85.0),
          child: _listPerson1.length > 0
              ? DropdownButton(
                  items: _listPerson1,
                  isExpanded: true,
                  value: _valuePerson1 ?? _listPerson1.first.value,
                  onChanged: (val) {
                    _valuePerson1 = val;

                    // print(val);
                    // st = 'ada';
                    // kas5 = _valueKas1;
                    // getPerson1(st);

                    setState(() {
                      // print(st);
                    });
                  },
                )
              : Container(),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(left: 85.0),
          child: _listPerson1.length > 0
              ? DropdownButton(
                  items: _listPerson1,
                  isExpanded: true,
                  value: _valuePerson1 ?? _listPerson1.first.value,
                  onChanged: (val) {
                    _valuePerson1 = val;

                    // print(val);
                    // st = 'ada';
                    // kas5 = _valueKas1;
                    // getPerson1(st);

                    setState(() {
                      // print(st);
                    });
                  },
                )
              : Container(),
        );
      }
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 85.0),
        child: _listKas2.length > 0
            ? DropdownButton(
                items: _listKas2,
                isExpanded: true,
                value: _valueKas2 ?? _listKas2.first.value,
                onChanged: (val) {
                  _valueKas2 = val;

                  print(val);

                  setState(() {});
                },
              )
            : Container(),
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
      if (indexradio2 == 1) {
        var db = new TDBHelper();
        Mykatagori mykatagori = await db.getByNamaPenerimaan(kategori);
        if (mykatagori != null) {
          _valueKategori = mytrans.katagori;
          setState(() {});
        } else {
          _valueKategori = _listKategori.first.value;
          setState(() {});
        }
      }
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
      if (indexradio2 == 2) {
        var db = new TDBHelper();
        Mykatagori mykatagori = await db.getByNamaPengeluaran(kategori);
        if (mykatagori != null) {
          _valueKategori2 = mytrans.katagori;
          setState(() {});
        } else {
          _valueKategori2 = _listKategori2.first.value;
          setState(() {});
        }
      }
    }
  }

  Widget kas() {
    return _listKas1.length > 0
        ? DropdownButton(
            items: _listKas1,
            // isExpanded: true,
            value: _valueKas1 ?? _listKas1.first.value,
            onChanged: (val) {
              _valueKas1 = val;
              // AddTransaksiPage(null, true);
              // val1 = '';
              // val1 = val;
              // indexradio5 = 1;
              // st = 'tidak';
              // kas5 = _valueKas1;

              print(val);
              // print(st);
              // getPerson1(st);
              setState(() {
                // kas5 = val;
                // getPerson1(_valueKas1);
              });
            },
          )
        : Container();
  }

  Widget kas3() {
    return _listKas1.length > 0
        ? DropdownButton(
            items: _listKas2,
            // isExpanded: true,
            value: _valueKas2 ?? _listKas2.first.value,
            onChanged: (val) {
              _valueKas2 = val;

              setState(() {});
            },
          )
        : Container();
  }

  void getKas1() async {
    List<Mykas> tempKategori = await db.getKas();
    for (Mykas item in tempKategori) {
      _listKas1.add(DropdownMenuItem(
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
              Text(item.kas),
            ],
          ),
        ),
        value: item.kas,
      ));
    }

    if (widget._isNew) {
      _valueKas1 = _listKas1.first.value;
      // kas5 = _valueKas1;
      setState(() {
        // getPerson1(kas5);
        // print(kas5);
      });
      // print(_valueKas1);
    } else {
      if (indexradio2 == 1) {
        var db = new TDBHelper();
        Mykas mykas = await db.getByNamaKas(kas5);
        if (mykas != null) {
          _valueKas1 = mytrans.kas;
          setState(() {});
        } else {
          _valueKas1 = _listKas1.first.value;
          setState(() {});
        }
      }
    }
  }

  void getKas2() async {
    List<Mykas> tempKategori = await db.getKas();
    for (Mykas item in tempKategori) {
      _listKas2.add(DropdownMenuItem(
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
              Text(item.kas)
            ],
          ),
        ),
        value: item.kas,
      ));
    }

    if (widget._isNew) {
      _valueKas2 = _listKas2.first.value;
      setState(() {});
    } else {
      if (indexradio2 == 2) {
        var db = new TDBHelper();
        Mykas mykas = await db.getByNamaKas(kas6);
        if (mykas != null) {
          _valueKas2 = mytrans.kas1;
          setState(() {});
        } else {
          _valueKas2 = _listKas2.first.value;
          setState(() {});
        }
      }
    }

    // _valueKategori = _listKategori.first.value;
    // setState(() {});
  }

  void getPerson1(st) async {
    print(st);
    if (st == 'ada') {
      if (indexradio2 == 1) {
        List<Myperson> tempPerson2 = await db.getPersonPenerimaanTr(_valueKas1);
        for (Myperson item in tempPerson2) {
          _listPerson1.add(DropdownMenuItem(
            child: Container(
              height: 200.0,
              child: Row(
                children: <Widget>[Text(item.kode)],
              ),
            ),
            value: item.kode,
          ));
        }
      } else {
        List<Myperson> tempPerson2 =
            await db.getPersonPengeluaranTr(_valueKas1);
        for (Myperson item in tempPerson2) {
          _listPerson1.add(DropdownMenuItem(
            child: Container(
              height: 200.0,
              child: Row(
                children: <Widget>[Text(item.kode)],
              ),
            ),
            value: item.kode,
          ));
        }
      }

      // print(kas5);

      //   if (widget._isNew) {
      //     // print(kas5);
      //     // if (_listPerson1.first.value == null) {
      //     //   _valuePerson1 = "tidak ada data";
      //     // } else {
      //     _valuePerson1 = _listPerson1.first.value;
      //     // }
      //     setState(() {});
      //   } else {
      //     if (indexradio2 == 1) {
      //       var db = new TDBHelper();
      //       Myperson myperson = await db.getByNamaPersonPenerimaan(person5);
      //       if (myperson != null) {
      //         _valuePerson1 = mytrans.sumber;
      //         setState(() {});
      //       } else {
      //         _valuePerson1 = _listPerson1.first.value;
      //         setState(() {});
      //       }
      //     }
      //   }
      // } else {
      //   List<Myperson> tempPerson1 = await db.getPersonPenerimaan();
      //   for (Myperson item in tempPerson1) {
      //     _listPerson1.add(DropdownMenuItem(
      //       child: Container(
      //         height: 200.0,
      //         child: Row(
      //           children: <Widget>[Text(item.kode)],
      //         ),
      //       ),
      //       value: item.kode,
      //     ));
      //   }

      // print(kas5);

      if (widget._isNew) {
        print(_listPerson1.length);
        if (_listPerson1.length <= 0) {
          _valuePerson1 = "";
        } else {
          print(_listPerson1.length);
          _valuePerson1 = _listPerson1.first.value;
        }
        setState(() {});
      } else {
        if (indexradio2 == 1) {
          var db = new TDBHelper();
          Myperson myperson = await db.getByNamaPersonPenerimaan(person5);
          print(myperson);
          if (myperson != null) {
            _valuePerson1 = mytrans.sumber;
            setState(() {});
          } else {
            _valuePerson1 = _listPerson1.first.value;
            setState(() {});
          }
        } else {
          var db = new TDBHelper();
          Myperson myperson = await db.getByNamaPersonPengeluaran(person5);
          print(myperson);
          if (myperson != null) {
            _valuePerson1 = mytrans.person;
            setState(() {});
          } else {
            _valuePerson1 = _listPerson1.first.value;
            setState(() {});
          }
        }
      }
    }
  }

  void getPerson2(st) async {
    print('tes');
    List<Myperson> tempPerson2 = await db.getPersonPengeluaranTr(_valueKas1);
    for (Myperson item in tempPerson2) {
      _listPerson2.add(DropdownMenuItem(
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
              Text(item.kode)
            ],
          ),
        ),
        value: item.kode,
      ));
    }

    if (widget._isNew) {
      _valuePerson2 = _listPerson2.first.value;
      setState(() {});
    } else {
      if (indexradio2 == 2) {
        var db = new TDBHelper();
        Myperson myperson = await db.getByNamaPersonPengeluaran(person5);
        if (myperson != null) {
          _valuePerson2 = mytrans.sumber;
          setState(() {});
        } else {
          _valuePerson2 = _listPerson2.first.value;
          setState(() {});
        }
      }
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getKategori();
  //   getKategori();
  //   getKategori();
  // }
}
