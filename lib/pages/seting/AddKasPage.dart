import 'package:catatan_keuangan/mykas.dart';
import 'package:catatan_keuangan/mytrans.dart';
import 'package:catatan_keuangan/mytrans2.dart';
import 'package:catatan_keuangan/mytrans3.dart';
import 'package:catatan_keuangan/mytrans6.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

import 'package:catatan_keuangan/mykatagori.dart';
import 'package:catatan_keuangan/TDBHelper.dart';

import 'package:intl/intl.dart';

class AddKasPage extends StatefulWidget {
  AddKasPage(this._mykas, this._isNew);

  final Mykas _mykas;
  final bool _isNew;
  // final bool visible;

  _AddKasPageState createState() => _AddKasPageState();
}

class _AddKasPageState extends State<AddKasPage> {
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

  Mykas mykas;
  Mytrans mytrans;
  // List<Mytrans> mytran = db.get

  Future addRecord() async {
    var db = new TDBHelper();
    Mykas mykas = await db.getByNamaKas(cNama.text);
    // nama2 = mykatagori.nama != null ? mykatagori.nama : "tidak";

    // print(nama2);

    if (mykas == null) {
      if (formkey.currentState.validate()) {
        var db = TDBHelper();

        var mykas = Mykas(
          cNama.text,
          jenis,
        );

        await db.saveKas(mykas);
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
    Mykas mykas = await db.getByNamaKas(cNama.text);
    // nama2 = mykatagori.nama != null ? mykatagori.nama : "tidak";

    // print(nama2);

    if (mykas == null) {
      if (formkey.currentState.validate()) {
        var jenis = 'pengeluaran';
        var db = new TDBHelper();

        var mykas = new Mykas(
          cNama.text,
          jenis,
        );
        mykas.setkasId(this.mykas.id);
        await db.updateKas(mykas);

        var mytrans3 = new Mytrans3(
          cNama.text,
          // mytrans.sumber
        );
        await db.updateTransKas(mytrans3, cNama.text, mytran3);

        var mytrans6 = new Mytrans6(
          cNama.text,
          // mytrans.sumber
        );
        await db.updateTransKas3(mytrans6, cNama.text, mytran3);
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

  void _delete(Mykas mykas) {
    var db = new TDBHelper();
    db.deleteKas(mykas);
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
            _delete(mykas);
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
    if (widget._mykas != null) {
      mykas = widget._mykas;
      cNama.text = mykas.kas;
      // jenis = mykas.tipe;
      mytran3 = mykas.kas;
    }

    // print(jenis);

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
      title = "Tambah Nama Kas";
      pp = "false";
      // String _formatedate = new DateFormat.yMMMd().format(_currentdate);
      // DateTime _currentdate = DateTime.now();
      BtnSave = false;
      BtnEdit = false;
    } else {
      title = "Edit Nama Kas";
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
                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10.0),
                //       border: Border.all(color: Colors.grey)),
                //   child: Padding(
                //     padding: const EdgeInsets.all(5.0),
                //     child: Row(
                //       children: <Widget>[
                //         IconButton(
                //           onPressed: () {
                //             _selectdate(context);
                //           },
                //           icon: Icon(Icons.date_range),
                //         ),
                //         SizedBox(
                //           width: 16,
                //         ),
                //         Expanded(
                //           child: Text("Date : $_formatedate"),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10.0,
                // ),
                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10.0),
                //     border: Border.all(color: Colors.grey),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(5.0),
                //     child: Row(
                //       children: <Widget>[
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Text(
                //             "Kategori : ",
                //             style: TextStyle(
                //                 fontSize: 15, fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //         SizedBox(
                //           width: 16,
                //         ),
                //         Expanded(
                //           child: Container(
                //             // decoration: BoxDecoration(
                //             //   border: BoxBorder(BorderRadius.circular(10)),
                //             // ),
                //             width: double.infinity,
                //             child: DropdownButtonHideUnderline(
                //               child: DropdownButton(
                //                 items: dataKategori(),
                //                 value: kategori,
                //                 onChanged: (int v) {
                //                   setState(() {
                //                     kategori = v;
                //                   });
                //                 },
                //               ),
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
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
                            hintText: "Nama Kas",
                            // labelText: "Sumber Penerimaan",
                            prefix: prefix0.Text(
                              "Nama Kas :",
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
                              val.isEmpty ? " Masukan Nama Kas" : null,
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 12.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: <Widget>[
                //       Expanded(
                //         child: TextFormField(
                //           decoration: InputDecoration(
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(10.0)),
                //             hintText: "Masukkan Angka",
                //             // labelText: "Jumlah Penerimaan",
                //             prefix: prefix0.Text(
                //               "Jumlah :",
                //               style: prefix0.TextStyle(
                //                   fontSize: 14.0,
                //                   fontWeight: prefix0.FontWeight.bold),
                //             ),

                //             // contentPadding:
                //             //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                //             hintStyle: TextStyle(fontSize: 12),
                //           ),
                //           keyboardType: TextInputType.number,
                //           controller: cJumlah,
                //           validator: (val) =>
                //               val.isEmpty ? " Masukan Jumlah Penerimaan" : null,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 12.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: <Widget>[
                //       Expanded(
                //         child: TextFormField(
                //           decoration: InputDecoration(
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(10.0)),
                //             hintText: "Keterangan : Optional",
                //             // labelText: "Keterangan",
                //             prefix: prefix0.Text(
                //               "Ket :",
                //               style: prefix0.TextStyle(
                //                   fontSize: 14.0,
                //                   fontWeight: prefix0.FontWeight.bold),
                //             ),

                //             // contentPadding:
                //             //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                //             // hintStyle: TextStyle(fontSize: 12),
                //           ),
                //           keyboardType: TextInputType.text,
                //           controller: cKet,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
