import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mykatagori.dart';
import 'package:catatan_keuangan/myrutin.dart';
import 'package:catatan_keuangan/mytrans.dart';
import 'package:catatan_keuangan/mytransjmpn.dart';
import 'package:catatan_keuangan/pages/transaksi/AddRutinPage.dart';

import 'package:catatan_keuangan/pages/transaksi/AddTransaksiPage.dart';

import 'package:catatan_keuangan/pages/transaksi/listtransaksijumlah.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listrutin extends StatefulWidget {
  final List<Myrutin> rutindata;

  Listrutin(this.rutindata, {Key key});
  @override
  _ListrutinState createState() => _ListrutinState();
}

class _ListrutinState extends State<Listrutin> {
  var f = NumberFormat(
    "#,###",
  );
  var db = new TDBHelper();

  Mytransjmpn mytransjmpn;

  String nama;
  String status2;
  String notrans2;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: db.getTransJumlah(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              var pendomdata = snapshot.data;
              return snapshot.hasData
                  ? new Listtransaksijumlah(pendomdata)
                  : Center(
                      child: Text(''),
                    );
            },
          ),
          _listpendom(),
          _addlist(),
        ],
      ),
    );
  }

  var jumlah2;
  String nama2 = "penerimaan";
  int jml;
  int jml1;
  int jml2;
  int jml3;

  Widget _listpendom() {
    return new Flexible(
        child: new ListView.builder(
      shrinkWrap: true,
      itemCount: widget.rutindata.length == null ? 0 : widget.rutindata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          // onTap: () {
          //   Navigator.of(context).push(MaterialPageRoute(
          //       builder: (BuildContext context) =>
          //           new AddTransaksiPage(widget.rutindata[i], false)));
          // },
          child: Column(
            children: <Widget>[
              Card(
                // color: widget.pendomdata[i].status2 == "Bayar Utang"
                //     ? Color(0xE5E59AAA)
                //     : Colors.white,
                child: ListTile(
                  leading: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.grey[1000],
                        child: Icon(
                          widget.rutindata[i].rek == "dompet"
                              ? Icons.style
                              : Icons.atm,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.rutindata[i].rek,
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        widget.rutindata[i].jenis,
                        style: TextStyle(
                            fontSize: 12,
                            color: widget.rutindata[i].jenis == "pengeluaran"
                                ? Colors.black
                                : Colors.black),
                      ),
                      // Row(
                      //   children: <Widget>[Text("data")],
                      // ),
                      // Text(widget.pendomdata[i].rek),

                      // Text(
                      //   widget.pendomdata[i].katagori,
                      //   style: TextStyle(fontSize: 10),
                      // ),

                      // Text(
                      //     "${int.parse(widget.pendomdata[i].jumlah) + int.parse(widget.pendomdata[i].jumlah)}"),
                      // widget.pendomdata[i].rek,
                      // style: TextStyle(fontSize: 14),

                      // Text(nama),
                      Text(
                        "Rp. ${f.format(widget.rutindata[i].jumlah).replaceAll(",", ".")}",
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.rutindata[i].jenis == "penerimaan"
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),

                      Text(
                        widget.rutindata[i].tipe,
                        style: TextStyle(
                            fontSize: 8,
                            color: widget.rutindata[i].tipe == "utang"
                                ? Colors.red
                                : widget.rutindata[i].tipe == "piutang"
                                    ? Colors.green
                                    : Colors.white),
                      ),
                      Text(
                        widget.rutindata[i].tipe == "utang" ||
                                widget.rutindata[i].tipe == "piutang"
                            ? "Jatuh Tempo: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse("${widget.rutindata[i].sortdate}")).toString()}"
                            : "",
                        style: TextStyle(
                            fontSize: 8,
                            color: widget.rutindata[i].tipe == "utang"
                                ? Colors.red
                                : widget.rutindata[i].tipe == "piutang"
                                    ? Colors.green
                                    : Colors.white),
                      ),
                    ],
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${widget.rutindata[i].jenis == "penerimaan" ? "Dari" : "Untuk"} : ${widget.rutindata[i].sumber}",
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        children: <Widget>[
                          Text(widget.rutindata[i].katagori,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          // Text(
                          //   widget.rutindata.status2 == "Bayar Utang" ||
                          //           widget.rutindata.status2 == "Bayar Piutang"
                          //       ? "Ke : ${widget.rutindata.urutanbayar}"
                          //       : "",
                          //   style: TextStyle(fontSize: 12, color: Colors.black),
                          // ),
                        ],
                      ),

                      Text(
                        "Ke : ${widget.rutindata[i].status}",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "Ke : ${widget.rutindata[i].status2}",
                        style: TextStyle(fontSize: 12),
                      ),

                      notransaksi(i),
                      status(i),
                      // Text(
                      //   "Status : ${widget.pendomdata[i].status3}",
                      //   style: TextStyle(fontSize: 12),
                      // ),
                      // Text("${widget.pendomdata[i].notrans}"),

                      // Text(widget.pendomdata[i].id.toString())
                    ],
                  ),
                  subtitle: Text(
                    "${widget.rutindata[i].ket}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
              ),
              new Divider(
                height: 2.0,
              ),
            ],
          ),
        );
      },
    ));
  }

  Widget notransaksi(i) {
    if (widget.rutindata[i].status2 == "Bayar Utang" ||
        widget.rutindata[i].status2 == "Bayar Piutang" ||
        widget.rutindata[i].tipe == "piutang" ||
        widget.rutindata[i].tipe == "utang") {
      return Text("ID : ${widget.rutindata[i].notransaksi.toString()}",
          style: TextStyle(
              color: widget.rutindata[i].tipe == "utang" ||
                      widget.rutindata[i].status2 == "Bayar Utang"
                  ? Colors.red
                  : Colors.green,
              fontSize: 12));
    } else {
      return Text(
        "",
        style: TextStyle(fontSize: 8),
      );
    }
  }

  Widget status(i) {
    if (widget.rutindata[i].status2 == "Bayar Utang" ||
        widget.rutindata[i].status2 == "Bayar Piutang" ||
        widget.rutindata[i].tipe == "piutang" ||
        widget.rutindata[i].tipe == "utang") {
      return Text("ID : ${widget.rutindata[i].status3}",
          style: TextStyle(
              color: widget.rutindata[i].tipe == "utang" ||
                      widget.rutindata[i].status2 == "Bayar Utang"
                  ? Colors.red
                  : Colors.green,
              fontSize: 8));
    } else {
      return Text("", style: TextStyle(fontSize: 8));
    }
  }

  Widget _addlist() {
    return new Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,

        // padding: const EdgeInsets.only(left: 0),
        child: RaisedButton(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: Colors.blue,

          // child: Text("Tanggal : $_formatedate"),
          child: Text(
            "Tambah Transaksi Rutin",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    new AddRutinPage(null, true)));
            // _selectdate(context);
          },
        ),
      ),
    );
  }

  // void initnama2(i) async {
  //   // Kategori kategori = await Kategori.initDatabase();
  //   Mykatagori mykatagori = await db.getById(widget.rutindata]);
  //   nama = mykatagori.nama != null ? mykatagori.nama : "";
  // }
}
