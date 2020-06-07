import 'package:catatan_keuangan/mykas.dart';
import 'package:catatan_keuangan/myperson.dart';
import 'package:catatan_keuangan/mytrans.dart';
import 'package:catatan_keuangan/mytrans2.dart';
import 'package:catatan_keuangan/mytrans3.dart';
import 'package:catatan_keuangan/mytrans5.dart';
import 'package:catatan_keuangan/mytrans6.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

import 'package:catatan_keuangan/mykatagori.dart';
import 'package:catatan_keuangan/TDBHelper.dart';

import 'package:intl/intl.dart';

class AddPersonPenerimaanPage extends StatefulWidget {
  AddPersonPenerimaanPage(this._myperson, this._isNew);

  final Myperson _myperson;
  final bool _isNew;
  // final bool visible;

  _AddPersonPenerimaanPageState createState() =>
      _AddPersonPenerimaanPageState();
}

class _AddPersonPenerimaanPageState extends State<AddPersonPenerimaanPage> {
  final formkey = new GlobalKey<FormState>();
  int indexradio1 = 1;
  int indexradio2 = 2;
  DateTime tglJatuhTempo = DateTime.now();
  DateTime tglTransaksi = DateTime.now();
  DateFormat formatTanggal = DateFormat("dd/MM/yyyy");

  String title;
  String pp;
  bool BtnSave = false;
  bool BtnEdit = true;
  bool BtnDelete = true;

  var createDate;
  var db = new TDBHelper();

  // var _currentdate;

  var cTgl = TextEditingController();
  var cNama = TextEditingController();
  var cNamaLengkap = TextEditingController();
  var cAlamat = TextEditingController();
  var cJumlah = TextEditingController();
  var cKet = TextEditingController();
  var cTelp = TextEditingController();

  int kategori = 1;

  DateTime _currentdate = DateTime.now();
  var now = DateTime.now();

  var jenis = 'pengeluaran';
  var kas = '';

  var jatuhtempo = DateTime.now();

  Mykas mykas;
  Myperson myperson;

  List<DropdownMenuItem> _listKas = [];

  String _valueKas;

  var kode = '';

  // List<Mytrans> mytran = db.get

  Future addRecord() async {
    var db = new TDBHelper();
    Myperson myperson = await db.getByNamaPersonPenerimaan(cNama.text);
    // nama2 = mykatagori.nama != null ? mykatagori.nama : "tidak";

    // print(nama2);

    if (myperson == null) {
      if (formkey.currentState.validate()) {
        var db = TDBHelper();

        var myperson = Myperson(
          cNama.text,
          _valueKas,
          cNamaLengkap.text,
          cTelp.text,
          cAlamat.text,
          'penerimaan',
        );

        await db.savePerson(myperson);
        print("saved");
        Navigator.of(context).pop();
      }
    } else {
      _confirmSave();
    }
  }

  var mytran3 = '';

  void updateRecord() async {
    if (cNama.text == kode) {
      var jenis = 'penerimaan';
      var db = new TDBHelper();

      // print(myperson.kode);

      var myperson = new Myperson(
        cNama.text,
        _valueKas,
        cNamaLengkap.text,
        cTelp.text,
        cAlamat.text,
        jenis,
      );
      myperson.setpersonId(this.myperson.id);
      await db.updatePerson(myperson);

      // var mytrans5 = new Mytrans5(
      //   cNama.text,
      //   // mytrans.sumber
      // );
      // await db.updateTransPerson(mytrans5, cNama.text, mytran3);

      // var mytrans6 = new Mytrans6(
      //   cNama.text,
      //   // mytrans.sumber
      // );
      // await db.updateTransKas3(mytrans6, cNama.text, mytran3);
      print(jenis);

      Navigator.of(context).pop();
    } else {
      var db = new TDBHelper();
      Myperson myperson = await db.getByNamaPersonPenerimaan(cNama.text);
      if (myperson == null) {
        if (formkey.currentState.validate()) {
          var jenis = 'penerimaan';
          var db = new TDBHelper();

          var myperson = new Myperson(
            cNama.text,
            _valueKas,
            cNamaLengkap.text,
            cTelp.text,
            cAlamat.text,
            jenis,
          );
          myperson.setpersonId(this.myperson.id);
          await db.updatePerson(myperson);

          var mytrans5 = new Mytrans5(
            cNama.text,
            // mytrans.sumber
          );
          await db.updateTransPerson(mytrans5, cNama.text, mytran3);

          // var mytrans6 = new Mytrans6(
          //   cNama.text,
          //   // mytrans.sumber
          // );
          // await db.updateTransKas3(mytrans6, cNama.text, mytran3);
          print(jenis);
          // var mytrans = new Mytrans(cNama.text,)
          // await db.updateTrans(mykatagori);
          Navigator.of(context).pop();
        }
      } else {
        _confirmSave();
      }
    }
  }

  void _confirmSave() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
        "Data Sudah Ada !!!",
        style: TextStyle(fontSize: 16.0, color: Colors.red),
      ),
      actions: <Widget>[
        // RaisedButton(
        //   color: Colors.red,
        //   child: Text("Ok Hapus", style: TextStyle(color: Colors.black)),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //     _delete(mykatagori);
        //     Navigator.of(context).pop();
        //   },
        // ),
        RaisedButton(
          color: Colors.green,
          child: Text("Ok", style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  void _saveData() {
    if (widget._isNew) {
      addRecord();
    } else {
      updateRecord();
    }
    // Navigator.of(context).pop();
  }

  void _delete(Myperson myperson) {
    var db = new TDBHelper();
    db.deletePerson(myperson);
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
            _delete(myperson);
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

  // var tgl = mytrans.sortdate;

  @override
  void initState() {
    if (widget._myperson != null) {
      myperson = widget._myperson;
      cNama.text = myperson.kode;
      _valueKas = myperson.namaKas;
      cNamaLengkap.text = myperson.person;
      cTelp.text = myperson.noTelp;
      cAlamat.text = myperson.alamat;
      kode = myperson.kode;
      kas = myperson.namaKas;
      // jenis = myperson.tipe;
      mytran3 = myperson.kode;
    }

    // print(jenis);
    getKas();
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

      // if (widget._isNew) {
      //   title = "new";
      // }
    }

    if (widget._isNew) {
      title = "Tambah List Penerima / Sumber";
      pp = "false";
      // String _formatedate = new DateFormat.yMMMd().format(_currentdate);
      // DateTime _currentdate = DateTime.now();
      BtnSave = false;
      BtnEdit = false;
    } else {
      title = "Edit List Penerima / Sumber";
      BtnSave = true;
      pp = "true";
      // String _formatedate = new DateFormat.yMMMd().format(mytrans.sortdate);
      // DateTime _currentdate = DateTime.now(mytrans.sortdate);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Kas : ",
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
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Nama Panggilan",
                            // labelText: "Sumber Penerimaan",
                            prefix: prefix0.Text(
                              "Nama Panggilan :",
                              style: prefix0.TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: prefix0.FontWeight.bold),
                            ),

                            // contentPadding:
                            //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          keyboardType: TextInputType.text,
                          controller: cNama,
                          validator: (val) =>
                              val.isEmpty ? " Masukan Nama Panggilan" : null,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Nama Lengkap",
                            // labelText: "Sumber Penerimaan",
                            prefix: prefix0.Text(
                              "Nama Lengkap :",
                              style: prefix0.TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: prefix0.FontWeight.bold),
                            ),

                            // contentPadding:
                            //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          keyboardType: TextInputType.text,
                          controller: cNamaLengkap,
                          // validator: (val) =>
                          //     val.isEmpty ? " Masukan Nama Lengkap" : null,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "No Telp",
                            // labelText: "Sumber Penerimaan",
                            prefix: prefix0.Text(
                              "No Telp :",
                              style: prefix0.TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: prefix0.FontWeight.bold),
                            ),

                            // contentPadding:
                            //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          keyboardType: TextInputType.text,
                          controller: cTelp,
                          // validator: (val) =>
                          //     val.isEmpty ? " Masukan Nama Lengkap" : null,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Alamat",
                            // labelText: "Sumber Penerimaan",
                            prefix: prefix0.Text(
                              "Alamat :",
                              style: prefix0.TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: prefix0.FontWeight.bold),
                            ),

                            // contentPadding:
                            //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                          keyboardType: TextInputType.text,
                          controller: cAlamat,
                          maxLines: 3,
                          // validator: (val) =>
                          //     val.isEmpty ? " Masukan Alamat" : null,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
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
      ),
    );
  }

  Widget katagori1() {
    return _listKas.length > 0
        ? DropdownButton(
            items: _listKas,
            // isExpanded: true,
            value: _valueKas ?? _listKas.first.value,
            onChanged: (val) {
              _valueKas = val;

              setState(() {});
            },
          )
        : Container();
  }

  void getKas() async {
    // Katagori dbKategori = await Katagori.initDatabase();
    //  var katagor ='';
    // katagor = indexradio2==1?"await db.getKatagoriPenerimaan()":"getKatagoriPengeluaran";
    List<Mykas> tempKas = await db.getKas();
    for (Mykas item in tempKas) {
      _listKas.add(DropdownMenuItem(
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
      _valueKas = _listKas.first.value;
      setState(() {});
    } else {
      var db = new TDBHelper();
      Myperson myperson = await db.getByNamaPersonPenerimaan(kas);

      if (myperson == null) {
        _valueKas = _listKas.first.value;
        setState(() {});
      } else {
        _valueKas = myperson.namaKas;
        setState(() {});
      }
    }

    // _valueKategori = _listKategori.first.value;
    // setState(() {});
  }
}
