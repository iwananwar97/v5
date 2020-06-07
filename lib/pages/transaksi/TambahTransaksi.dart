import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

import 'package:intl/intl.dart';

class TambahTransaksi extends StatefulWidget {
  TambahTransaksi({Key key}) : super(key: key);

  _TambahTransaksiState createState() => _TambahTransaksiState();
}

class _TambahTransaksiState extends State<TambahTransaksi> {
  int indexradio1 = 2;
  int indexradio2 = 1;
  DateTime tglJatuhTempo = DateTime.now();
  DateTime tglTransaksi = DateTime.now();
  DateFormat formatTanggal = DateFormat("dd/MM/yyyy");

  var cTgl = TextEditingController();
  var cDari = TextEditingController();
  var cJumlah = TextEditingController();
  var cKet = TextEditingController();
  int kategori = 1;

  DateTime _currentdate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String _formatedate = new DateFormat.yMMMd().format(_currentdate);

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Penerimaan Kas Dompet'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _selectdate(context);
                        },
                        icon: Icon(Icons.date_range),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text("Date : $_formatedate"),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
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
                      Expanded(
                        child: Container(
                          // decoration: BoxDecoration(
                          //   border: BoxBorder(BorderRadius.circular(10)),
                          // ),
                          width: double.infinity,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              items: dataKategori(),
                              value: kategori,
                              onChanged: (int v) {
                                setState(() {
                                  kategori = v;
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
                          hintText: "Masukan Nama atau Toko",
                          // labelText: "Sumber Penerimaan",
                          prefix: prefix0.Text(
                            "Sumber :",
                            style: prefix0.TextStyle(
                                fontSize: 14.0,
                                fontWeight: prefix0.FontWeight.bold),
                          ),

                          // contentPadding:
                          //     EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        keyboardType: TextInputType.text,
                        controller: cDari,
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
                          hintText: "Masukkan Angka",
                          // labelText: "Jumlah Penerimaan",
                          prefix: prefix0.Text(
                            "Jumlah :",
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
                          hintText: "Keterangan : Optional",
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext) {
                          return TambahTransaksi();
                        }));
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
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Batal"),
                    color: Colors.yellow,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future showTanggal() {
  //   DateTime = showDatePicker(
  //       context: context,
  //       initialDate: tglTransaksi,
  //       firstDate: DateTime(2015),
  //       lastDate: DateTime(2030));

  //   // if (pick != null) {
  //   //   setState(() {
  //   //     if (from == 1) {
  //   //       tglJatuhTempo = pick;
  //   //     } else {
  //   //       tglTransaksi = pick;
  //   //     }
  //   //   });
  //   // }
  // }

  // Widget widgetjatuhTempo() {
  //   Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),

  //     // onTap: () {
  //     //   showTanggal();
  //     // },
  //     child: ListTile(
  //       leading: Icon(Icons.date_range),
  //       title: Text("Tanggal Jatuh Tempo"),
  //       subtitle: Text(formatTanggal.format(tglJatuhTempo)),
  //     ),
  //   );
  // }

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
}
