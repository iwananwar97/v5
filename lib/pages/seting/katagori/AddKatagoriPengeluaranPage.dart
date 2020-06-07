import 'package:catatan_keuangan/mytrans.dart';
import 'package:catatan_keuangan/mytrans2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

import 'package:catatan_keuangan/mykatagori.dart';
import 'package:catatan_keuangan/TDBHelper.dart';

import 'package:intl/intl.dart';

class AddKatagoriPengeluaranPage extends StatefulWidget {
  AddKatagoriPengeluaranPage(this._mykatagori, this._isNew);

  final Mykatagori _mykatagori;
  final bool _isNew;
  // final bool visible;

  _AddKatagoriPengeluaranPageState createState() =>
      _AddKatagoriPengeluaranPageState();
}

class _AddKatagoriPengeluaranPageState
    extends State<AddKatagoriPengeluaranPage> {
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

  // var _currentdate;

  var cTgl = TextEditingController();
  var cNama = TextEditingController();
  var cJumlah = TextEditingController();
  var cKet = TextEditingController();

  int kategori = 1;

  DateTime _currentdate = DateTime.now();
  var now = DateTime.now();

  var jenis = 'pengeluaran';

  var jatuhtempo = DateTime.now();

  Mykatagori mykatagori;
  Mytrans mytrans;
  // List<Mytrans> mytran = db.get

  Future addRecord() async {
    var db = new TDBHelper();
    Mykatagori mykatagori = await db.getByNamaPengeluaran(cNama.text);
    // nama2 = mykatagori.nama != null ? mykatagori.nama : "tidak";

    // print(nama2);

    if (mykatagori == null) {
      if (formkey.currentState.validate()) {
        var db = TDBHelper();

        var mykatagori = Mykatagori(
          cNama.text,
          jenis,
          '',
        );

        await db.saveKatagori(mykatagori);
        print("saved");
        Navigator.of(context).pop();
      }
    } else {
      _confirmSave();
    }
  }

  var mytran3 = '';

  void updateRecord() async {
    var db = new TDBHelper();
    Mykatagori mykatagori = await db.getByNamaPengeluaran(cNama.text);
    // nama2 = mykatagori.nama != null ? mykatagori.nama : "tidak";

    // print(nama2);

    if (mykatagori == null) {
      if (formkey.currentState.validate()) {
        var jenis = 'pengeluaran';
        var db = new TDBHelper();

        var mykatagori = new Mykatagori(
          cNama.text,
          jenis,
          st,
        );
        mykatagori.setKatagoriId(this.mykatagori.id);
        await db.updateKatagori(mykatagori);

        var mytrans2 = new Mytrans2(
          cNama.text,
          // mytrans.sumber
        );
        await db.updateTrans2(mytrans2, cNama.text, mytran3);
        print(jenis);
        // var mytrans = new Mytrans(cNama.text,)
        // await db.updateTrans(mykatagori);
        Navigator.of(context).pop();
      }
    } else {
      _confirmSave();
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

  void _delete(Mykatagori mykatagori) {
    var db = new TDBHelper();
    db.deleteKatagori(mykatagori);
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
            _delete(mykatagori);
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

  var st = '';

  @override
  void initState() {
    if (widget._mykatagori != null) {
      mykatagori = widget._mykatagori;
      cNama.text = mykatagori.nama;
      jenis = mykatagori.jenis;
      mytran3 = mykatagori.nama;
      st = mykatagori.st;
    }

    print(jenis);

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
      title = "Tambah Penerimaan Dompet";
      pp = "false";
      // String _formatedate = new DateFormat.yMMMd().format(_currentdate);
      // DateTime _currentdate = DateTime.now();
      BtnSave = false;
      BtnEdit = false;
    } else {
      title = "Edit Katagori Pengeluaran";
      // BtnSave = false;
      pp = "true";
      if (st == 'y') {
        BtnSave = false;
      } else {
        BtnSave = true;
      }
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
                            hintText: "Nama Katagori",
                            // labelText: "Sumber Penerimaan",
                            prefix: prefix0.Text(
                              "Nama Katagori :",
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
                              val.isEmpty ? " Masukan Nama Katagori" : null,
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
}
