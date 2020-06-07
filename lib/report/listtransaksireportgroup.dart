import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mykatagori.dart';

import 'package:catatan_keuangan/mytransgroup.dart';
import 'package:catatan_keuangan/mytransjmpn.dart';

import 'package:catatan_keuangan/pages/transaksi/AddTransaksiPage.dart';
import 'package:catatan_keuangan/report/TransaksiDetailReport.dart';
import 'package:catatan_keuangan/report/listtransaksijumlahgroup.dart';
import 'package:catatan_keuangan/report/listtransaksijumlahgroupharian.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listtransaksireportgroup extends StatefulWidget {
  final List<Mytransgroup> groupdata;

  Listtransaksireportgroup(this.groupdata, {Key key});
  @override
  _ListtransaksireportgroupState createState() =>
      _ListtransaksireportgroupState();
}

class _ListtransaksireportgroupState extends State<Listtransaksireportgroup> {
  var f = NumberFormat(
    "#,###",
  );
  var db = new TDBHelper();

  Mytransjmpn mytransjmpn;
  Mytransgroup mytransgroup;

  String nama;
  int jumlah;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: db.getTransJumlahgroup(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              var pendomdata = snapshot.data;
              return snapshot.hasData
                  ? new Listtransaksijumlahgroup(pendomdata)
                  : Center(
                      child: Text(''),
                    );
            },
          ),
          _listpendom(),
          // _addlist(),
        ],
      ),
    );
  }

  var jumlah2;

  // void jumlah() async {
  //   // var dbClient = await db;

  //   await db.getJumlahPenerimaanHarian();
  //   return;
  //   // return result;
  // }

  Widget _listpendom() {
    return new Flexible(
        child: new ListView.builder(
      shrinkWrap: true,
      itemCount: widget.groupdata.length == null ? 0 : widget.groupdata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    new TransaksiDetailReport(widget.groupdata[i])));
          },
          child: Card(
            color: Colors.grey[200],
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString() ==
                                  "Sunday"
                              ? "Minggu, "
                              : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString() ==
                                      "Monday"
                                  ? "Senin, "
                                  : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString() ==
                                          "Tuesday"
                                      ? "Selasa, "
                                      : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString() ==
                                              "Wednesday"
                                          ? "Rabu, "
                                          : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString() ==
                                                  "Thursday"
                                              ? "Kamis, "
                                              : DateFormat(DateFormat.WEEKDAY)
                                                          .format(DateTime.parse(
                                                              "${widget.groupdata[i].createdate}"))
                                                          .toString() ==
                                                      "Friday"
                                                  ? "Jum'at, "
                                                  : DateFormat(DateFormat.WEEKDAY)
                                                              .format(DateTime.parse("${widget.groupdata[i].createdate}"))
                                                              .toString() ==
                                                          "Saturday"
                                                      ? "Sabtu, "
                                                      : "",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                        ),
                        Text(
                            "${DateFormat(DateFormat.DAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString()} ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700])),
                        Text(
                            "${DateFormat(DateFormat.MONTH).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString()} ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700])),
                        Text(
                            "${DateFormat(DateFormat.YEAR).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString()}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700])),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("DOMPET",style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "BANK",style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  FutureBuilder(
            future: db.getTransJumlahgroupharian(DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse(widget.groupdata[i].createdate))),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              var hariandata = snapshot.data;
              return snapshot.hasData
                  ? new Listtransaksijumlahgroupharian(hariandata)
                  : Center(
                      child: Text(''),
                    );
            },
          ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: <Widget>[
                     
                  //     Container(
                            
                  //         child: 
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             children: <Widget>[
                              
                  //             Text(
                  //               widget.groupdata[i].total != null
                  //                   ? "Rp: ${f.format(widget.groupdata[i].total).replaceAll(",", ".")}"
                  //                   : "Rp: ${0.toString()}",
                  //               style: TextStyle(color: Colors.green),
                  //             ),
                  //             Text(
                  //               widget.groupdata[i].total1 != null
                  //                   ? "Rp. ${f.format(widget.groupdata[i].total1).replaceAll(",", ".")}"
                  //                   : "Rp. ${0.toString()}",
                  //               style: TextStyle(color: Colors.red),
                  //             )
                  //           ]),
                  //         ),
                  //       ),
                    
                  //     Container(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.end,
                  //           children: <Widget>[
                  //           Text(
                  //             widget.groupdata[i].total != null
                  //                 ? "Rp: ${f.format(widget.groupdata[i].total).replaceAll(",", ".")}"
                  //                 : "Rp: ${0.toString()}",
                  //             style: TextStyle(color: Colors.green),
                  //           ),
                  //           Text(
                  //             widget.groupdata[i].total1 != null
                  //                 ? "Rp. ${f.format(widget.groupdata[i].total1).replaceAll(",", ".")}"
                  //                 : "Rp. ${0.toString()}",
                  //             style: TextStyle(color: Colors.red),
                  //           )
                  //         ]),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Text("data"),
                  // Text("data"),
                ]),
          ),
        );
      },
    ));
  }

  void getData() async {
    var db = new TDBHelper();
    var result = await db.getTransGroup();
    // jumlah = result.toString();
    // setState(() {
    //   jumlah=int.parse(result);
    // });
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
    Mykatagori mykatagori = await db.getById(widget.groupdata[i]);
    nama = mykatagori.nama != null ? mykatagori.nama : "";
  }
}
