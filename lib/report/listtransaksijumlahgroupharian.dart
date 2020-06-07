import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mykatagori.dart';

import 'package:catatan_keuangan/mytransjmpn.dart';

import 'package:catatan_keuangan/mytransjumlahgroup.dart';
import 'package:catatan_keuangan/mytransjumlahgroupharian.dart';

import 'package:catatan_keuangan/pages/transaksi/AddTransaksiPage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listtransaksijumlahgroupharian extends StatefulWidget {
  final List<Mytransjumlahgroupharian> hariandata;

  Listtransaksijumlahgroupharian(this.hariandata, {Key key});
  @override
  _ListtransaksijumlahgroupharianState createState() =>
      _ListtransaksijumlahgroupharianState();
}

class _ListtransaksijumlahgroupharianState
    extends State<Listtransaksijumlahgroupharian> {
  var f = NumberFormat(
    "#,###",
  );
  var db = new TDBHelper();

  Mytransjmpn mytransjmpn;
  int sisautang, sisautang2, utangdompet, bayardompet, utangbank, bayarbank;

  // List<Mytransjmpn> total;

  String nama;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      shrinkWrap: true,
      itemCount:
          widget.hariandata.length == null ? 0 : widget.hariandata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          // onTap: () {
          //   Navigator.of(context).push(MaterialPageRoute(
          //       builder: (BuildContext context) =>
          //           ConfirmPage()));
          // },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.hariandata[i].total != null
                              ? "Rp: ${f.format(widget.hariandata[i].total).replaceAll(",", ".")}"
                              : "Rp: ${0.toString()}",
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          widget.hariandata[i].total1 != null
                              ? "Rp. ${f.format(widget.hariandata[i].total1).replaceAll(",", ".")}"
                              : "Rp. ${0.toString()}",
                          style: TextStyle(color: Colors.red),
                        ),
                        _getDataSaldoDompet(i),
                      ]),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.hariandata[i].total4 != null
                              ? "Rp: ${f.format(widget.hariandata[i].total4).replaceAll(",", ".")}"
                              : "Rp: ${0.toString()}",
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          widget.hariandata[i].total5 != null
                              ? "Rp. ${f.format(widget.hariandata[i].total5).replaceAll(",", ".")}"
                              : "Rp. ${0.toString()}",
                          style: TextStyle(color: Colors.red),
                        ),
                        _getDataSaldoBank(i)
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getDataSaldoDompet(i) {
    if (widget.hariandata[i].total != null ||
        widget.hariandata[i].total1 != null) {
      utangdompet =
          widget.hariandata[i].total != null ? widget.hariandata[i].total : 0;
      bayardompet =
          widget.hariandata[i].total1 != null ? widget.hariandata[i].total1 : 0;

      sisautang = utangdompet - bayardompet;
      // if (sisautang != null) {
      return new Text(
        widget.hariandata[i].total1 != null ||
                widget.hariandata[i].total != null
            ? "Rp. ${f.format(sisautang).replaceAll(",", ".")}"
            : 0.toString(),
        style: TextStyle(color: Colors.deepPurple),
      );
    } else {
      return new Text(
        "Rp. 0",
        style: TextStyle(color: Colors.deepPurple),
      );
    }
  }

  Widget _getDataSaldoBank(i) {
    if (widget.hariandata[i].total4 != null ||
        widget.hariandata[i].total5 != null) {
      utangbank =
          widget.hariandata[i].total4 != null ? widget.hariandata[i].total4 : 0;
      bayarbank =
          widget.hariandata[i].total5 != null ? widget.hariandata[i].total5 : 0;

      sisautang2 = utangbank - bayarbank;

      // if (sisautang != null) {
      return new Text(
        widget.hariandata[i].total4 != null ||
                widget.hariandata[i].total5 != null
            ? "Rp. ${f.format(sisautang2).replaceAll(",", ".")}"
            : 0.toString(),
        style: TextStyle(color: Colors.deepPurple),
      );
    } else {
      return new Text(
        "Rp. 0",
        style: TextStyle(color: Colors.deepPurple),
      );
    }
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
      itemCount:
          widget.hariandata.length == null ? 0 : widget.hariandata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          // onTap: () {
          //   Navigator.of(context).push(MaterialPageRoute(
          //       builder: (BuildContext context) =>
          //           new AddTransaksiPage(widget.hariandata[i], false)));
          // },
          child: Column(
            children: <Widget>[
              Text(widget.hariandata[i].total1.toString()),
              // Card(
              //   // color: widget.hariandata[i].status2 == "Bayar Utang"
              //   //     ? Color(0xE5E59AAA)
              //   //     : Colors.white,
              //   child: ListTile(
              //     leading: Column(
              //       children: <Widget>[
              //         CircleAvatar(
              //           backgroundColor: Colors.grey[1000],
              //           child: Icon(
              //             widget.hariandata[i].rek == "dompet"
              //                 ? Icons.style
              //                 : Icons.atm,
              //             color: Colors.white,
              //           ),
              //         ),
              //         Text(
              //           widget.hariandata[i].rek,
              //           style: TextStyle(fontSize: 10),
              //         ),
              //       ],
              //     ),
              //     trailing: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: <Widget>[
              //         Text(
              //           widget.hariandata[i].jenis,
              //           style: TextStyle(
              //               fontSize: 12,
              //               color: widget.hariandata[i].jenis == "pengeluaran"
              //                   ? Colors.black
              //                   : Colors.black),
              //         ),
              //         // Row(
              //         //   children: <Widget>[Text("data")],
              //         // ),
              //         // Text(widget.hariandata[i].rek),

              //         // Text(
              //         //   widget.hariandata[i].katagori,
              //         //   style: TextStyle(fontSize: 10),
              //         // ),

              //         // Text(
              //         //     "${int.parse(widget.hariandata[i].jumlah) + int.parse(widget.hariandata[i].jumlah)}"),
              //         // widget.hariandata[i].rek,
              //         // style: TextStyle(fontSize: 14),

              //         // Text(nama),
              //         Text(
              //           "Rp. ${f.format(widget.hariandata[i].jumlah).replaceAll(",", ".")}",
              //           style: TextStyle(
              //             fontSize: 14,
              //             color: widget.hariandata[i].jenis == "penerimaan"
              //                 ? Colors.green
              //                 : Colors.red,
              //           ),
              //         ),

              //         Text(
              //           widget.hariandata[i].tipe,
              //           style: TextStyle(
              //               fontSize: 8,
              //               color: widget.hariandata[i].tipe == "utang"
              //                   ? Colors.red
              //                   : widget.hariandata[i].tipe == "piutang"
              //                       ? Colors.green
              //                       : Colors.white),
              //         ),
              //         Text(
              //           widget.hariandata[i].tipe == "utang" ||
              //                   widget.hariandata[i].tipe == "piutang"
              //               ? "Jatuh Tempo: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse("${widget.hariandata[i].sortdate}")).toString()}"
              //               : "",
              //           style: TextStyle(
              //               fontSize: 8,
              //               color: widget.hariandata[i].tipe == "utang"
              //                   ? Colors.red
              //                   : widget.hariandata[i].tipe == "piutang"
              //                       ? Colors.green
              //                       : Colors.white),
              //         ),
              //       ],
              //     ),
              //     title: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: <Widget>[
              //         Text(
              //           "${widget.hariandata[i].jenis == "penerimaan" ? "Dari" : "Untuk"} : ${widget.hariandata[i].sumber}",
              //           style: TextStyle(fontSize: 12),
              //         ),
              //         Row(
              //           children: <Widget>[
              //             Text(widget.hariandata[i].katagori,
              //                 style: TextStyle(
              //                   fontSize: 12,
              //                   color: Colors.black,
              //                 )),
              //             SizedBox(
              //               width: 10,
              //             ),
              //             Text(
              //               widget.hariandata[i].status2 == "Bayar Utang" ||
              //                       widget.hariandata[i].status2 ==
              //                           "Bayar Piutang"
              //                   ? "Ke : ${widget.hariandata[i].urutanbayar}"
              //                   : "",
              //               style: TextStyle(fontSize: 12, color: Colors.black),
              //             ),
              //           ],
              //         ),
              //         // Text(
              //         //   "Ke : ${widget.hariandata[i].urutanbayar}",
              //         //   style: TextStyle(fontSize: 12),
              //         // ),

              //         notransaksi(i),
              //         // Text("${widget.hariandata[i].notrans}"),

              //         // Text(widget.hariandata[i].id.toString())
              //       ],
              //     ),
              //     subtitle: Text(
              //       "${widget.hariandata[i].ket}",
              //       maxLines: 3,
              //       overflow: TextOverflow.ellipsis,
              //       style: TextStyle(fontSize: 12, color: Colors.black),
              //     ),
              //   ),
              // ),
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
    if (widget.hariandata[i].status2 == "Bayar Utang" ||
        widget.hariandata[i].status2 == "Bayar Piutang" ||
        widget.hariandata[i].tipe == "piutang" ||
        widget.hariandata[i].tipe == "utang") {
      return Text("ID : ${widget.hariandata[i].notransaksi.toString()}",
          style: TextStyle(
              color: widget.hariandata[i].tipe == "utang" ||
                      widget.hariandata[i].status2 == "Bayar Utang"
                  ? Colors.red
                  : Colors.green,
              fontSize: 12));
    } else {
      return Text("");
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
            "Tambah Transaksi",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    new AddTransaksiPage(null, true)));
            // _selectdate(context);
          },
        ),
      ),
    );
  }

  void initnama2(i) async {
    // Kategori kategori = await Kategori.initDatabase();
    Mykatagori mykatagori = await db.getById(widget.hariandata[i]);
    nama = mykatagori.nama != null ? mykatagori.nama : "";
  }
}
