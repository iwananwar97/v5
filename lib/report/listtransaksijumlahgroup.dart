import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mykatagori.dart';

import 'package:catatan_keuangan/mytransjmpn.dart';

import 'package:catatan_keuangan/mytransjumlahgroup.dart';

import 'package:catatan_keuangan/pages/transaksi/AddTransaksiPage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listtransaksijumlahgroup extends StatefulWidget {
  final List<Mytransjumlahgroup> pendomdata;

  Listtransaksijumlahgroup(this.pendomdata, {Key key});
  @override
  _ListtransaksijumlahgroupState createState() =>
      _ListtransaksijumlahgroupState();
}

class _ListtransaksijumlahgroupState extends State<Listtransaksijumlahgroup> {
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
          widget.pendomdata.length == null ? 0 : widget.pendomdata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          // onTap: () {
          //   Navigator.of(context).push(MaterialPageRoute(
          //       builder: (BuildContext context) =>
          //           ConfirmPage()));
          // },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Penerimaan Dompet",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      // SizedBox(width: 5,),

                      Text(
                        widget.pendomdata[i].total != null
                            ? "Rp: ${f.format(widget.pendomdata[i].total).replaceAll(",", ".")}"
                            : "Rp: ${0.toString()}",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Pengeluaran Dompet",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        widget.pendomdata[i].total1 != null
                            ? "Rp. ${f.format(widget.pendomdata[i].total1).replaceAll(",", ".")}"
                            : "Rp. ${0.toString()}",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Saldo Dompet",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      _getDataSaldoDompet(i),
                    ],
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Penerimaan Bank",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      // SizedBox(width: 5,),

                      Text(
                        widget.pendomdata[i].total4 != null
                            ? "Rp: ${f.format(widget.pendomdata[i].total4).replaceAll(",", ".")}"
                            : "Rp: ${0.toString()}",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Pengeluaran Bank",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        widget.pendomdata[i].total5 != null
                            ? "Rp. ${f.format(widget.pendomdata[i].total5).replaceAll(",", ".")}"
                            : "Rp. ${0.toString()}",
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Saldo Bank",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      _getDataSaldoBank(i),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Text("Piutang",
                  //       style: TextStyle(color: Colors.blue),),
                  //     Text(
                  //       widget.pendomdata[i].total3 != null
                  //           ? "Rp. ${f.format(widget.pendomdata[i].total3).replaceAll(",", ".")}"
                  //           : "Rp. ${0.toString()}",
                  //       style: TextStyle(color: Colors.blue),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Text("Utang",
                  //       style: TextStyle(color: Colors.deepOrange),),
                  //     Text(
                  //       widget.pendomdata[i].total2 != null
                  //           ? "Rp. ${f.format(widget.pendomdata[i].total2).replaceAll(",", ".")}"
                  //           : "Rp. ${0.toString()}",
                  //       style: TextStyle(color: Colors.deepOrange),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  new Divider(
                    height: 1.0,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getDataSaldoDompet(i) {
    if (widget.pendomdata[i].total != null ||
        widget.pendomdata[i].total1 != null) {
      utangdompet =
          widget.pendomdata[i].total != null ? widget.pendomdata[i].total : 0;
      bayardompet =
          widget.pendomdata[i].total1 != null ? widget.pendomdata[i].total1 : 0;

      sisautang = utangdompet - bayardompet;
      // if (sisautang != null) {
      return new Text(
        widget.pendomdata[i].total1 != null ||
                widget.pendomdata[i].total != null
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
    if (widget.pendomdata[i].total4 != null ||
        widget.pendomdata[i].total5 != null) {
      utangbank =
          widget.pendomdata[i].total4 != null ? widget.pendomdata[i].total4 : 0;
      bayarbank =
          widget.pendomdata[i].total5 != null ? widget.pendomdata[i].total5 : 0;

      sisautang2 = utangbank - bayarbank;

      // if (sisautang != null) {
      return new Text(
        widget.pendomdata[i].total4 != null ||
                widget.pendomdata[i].total5 != null
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
          widget.pendomdata.length == null ? 0 : widget.pendomdata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          // onTap: () {
          //   Navigator.of(context).push(MaterialPageRoute(
          //       builder: (BuildContext context) =>
          //           new AddTransaksiPage(widget.pendomdata[i], false)));
          // },
          child: Column(
            children: <Widget>[
              Text(widget.pendomdata[i].total1.toString()),
              // Card(
              //   // color: widget.pendomdata[i].status2 == "Bayar Utang"
              //   //     ? Color(0xE5E59AAA)
              //   //     : Colors.white,
              //   child: ListTile(
              //     leading: Column(
              //       children: <Widget>[
              //         CircleAvatar(
              //           backgroundColor: Colors.grey[1000],
              //           child: Icon(
              //             widget.pendomdata[i].rek == "dompet"
              //                 ? Icons.style
              //                 : Icons.atm,
              //             color: Colors.white,
              //           ),
              //         ),
              //         Text(
              //           widget.pendomdata[i].rek,
              //           style: TextStyle(fontSize: 10),
              //         ),
              //       ],
              //     ),
              //     trailing: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: <Widget>[
              //         Text(
              //           widget.pendomdata[i].jenis,
              //           style: TextStyle(
              //               fontSize: 12,
              //               color: widget.pendomdata[i].jenis == "pengeluaran"
              //                   ? Colors.black
              //                   : Colors.black),
              //         ),
              //         // Row(
              //         //   children: <Widget>[Text("data")],
              //         // ),
              //         // Text(widget.pendomdata[i].rek),

              //         // Text(
              //         //   widget.pendomdata[i].katagori,
              //         //   style: TextStyle(fontSize: 10),
              //         // ),

              //         // Text(
              //         //     "${int.parse(widget.pendomdata[i].jumlah) + int.parse(widget.pendomdata[i].jumlah)}"),
              //         // widget.pendomdata[i].rek,
              //         // style: TextStyle(fontSize: 14),

              //         // Text(nama),
              //         Text(
              //           "Rp. ${f.format(widget.pendomdata[i].jumlah).replaceAll(",", ".")}",
              //           style: TextStyle(
              //             fontSize: 14,
              //             color: widget.pendomdata[i].jenis == "penerimaan"
              //                 ? Colors.green
              //                 : Colors.red,
              //           ),
              //         ),

              //         Text(
              //           widget.pendomdata[i].tipe,
              //           style: TextStyle(
              //               fontSize: 8,
              //               color: widget.pendomdata[i].tipe == "utang"
              //                   ? Colors.red
              //                   : widget.pendomdata[i].tipe == "piutang"
              //                       ? Colors.green
              //                       : Colors.white),
              //         ),
              //         Text(
              //           widget.pendomdata[i].tipe == "utang" ||
              //                   widget.pendomdata[i].tipe == "piutang"
              //               ? "Jatuh Tempo: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse("${widget.pendomdata[i].sortdate}")).toString()}"
              //               : "",
              //           style: TextStyle(
              //               fontSize: 8,
              //               color: widget.pendomdata[i].tipe == "utang"
              //                   ? Colors.red
              //                   : widget.pendomdata[i].tipe == "piutang"
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
              //           "${widget.pendomdata[i].jenis == "penerimaan" ? "Dari" : "Untuk"} : ${widget.pendomdata[i].sumber}",
              //           style: TextStyle(fontSize: 12),
              //         ),
              //         Row(
              //           children: <Widget>[
              //             Text(widget.pendomdata[i].katagori,
              //                 style: TextStyle(
              //                   fontSize: 12,
              //                   color: Colors.black,
              //                 )),
              //             SizedBox(
              //               width: 10,
              //             ),
              //             Text(
              //               widget.pendomdata[i].status2 == "Bayar Utang" ||
              //                       widget.pendomdata[i].status2 ==
              //                           "Bayar Piutang"
              //                   ? "Ke : ${widget.pendomdata[i].urutanbayar}"
              //                   : "",
              //               style: TextStyle(fontSize: 12, color: Colors.black),
              //             ),
              //           ],
              //         ),
              //         // Text(
              //         //   "Ke : ${widget.pendomdata[i].urutanbayar}",
              //         //   style: TextStyle(fontSize: 12),
              //         // ),

              //         notransaksi(i),
              //         // Text("${widget.pendomdata[i].notrans}"),

              //         // Text(widget.pendomdata[i].id.toString())
              //       ],
              //     ),
              //     subtitle: Text(
              //       "${widget.pendomdata[i].ket}",
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
    if (widget.pendomdata[i].status2 == "Bayar Utang" ||
        widget.pendomdata[i].status2 == "Bayar Piutang" ||
        widget.pendomdata[i].tipe == "piutang" ||
        widget.pendomdata[i].tipe == "utang") {
      return Text("ID : ${widget.pendomdata[i].notransaksi.toString()}",
          style: TextStyle(
              color: widget.pendomdata[i].tipe == "utang" ||
                      widget.pendomdata[i].status2 == "Bayar Utang"
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
    Mykatagori mykatagori = await db.getById(widget.pendomdata[i]);
    nama = mykatagori.nama != null ? mykatagori.nama : "";
  }
}
