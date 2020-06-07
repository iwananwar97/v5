import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mypiutangjumlah.dart';
import 'package:catatan_keuangan/mytranspiutang.dart';

import 'package:catatan_keuangan/tagihan/piutang/UpdatePiutangPage.dart';
import 'package:catatan_keuangan/tagihan/piutang/piutangjumlah.dart';
import 'package:catatan_keuangan/tagihan/piutang/semuapiutangdetail.dart';
import 'package:catatan_keuangan/tagihan/piutang/totalpiutangPage.dart';

import 'package:catatan_keuangan/tagihan/utang/semuautangdetail.dart';
import 'package:catatan_keuangan/tagihan/utang/totalutangPage.dart';
import 'package:catatan_keuangan/tagihan/utang/utangjumlah.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listpiutangbelumlunas extends StatefulWidget {
  final List<Mytranspiutang> piutangdata;
  // final Mytransutang _mytransutang;
  // final List<Mytrans> utangdata2;

  Listpiutangbelumlunas(this.piutangdata, {Key key});
  @override
  _ListpiutangbelumlunasState createState() => _ListpiutangbelumlunasState();
}

class _ListpiutangbelumlunasState extends State<Listpiutangbelumlunas> {
  var f = NumberFormat(
    "#,###",
  );
  var db = new TDBHelper();
  // _getData();
  String notrans2;
  int bayar1;
  int jumlah;
  int sisa;
  int sisautang;
  int bayar2;
  Mypiutangjumlah mypiutangjumlah;
  Mytranspiutang mytranspiutang;

  // @override
  // void initState() {
  //   // var item = List<Mytransutang> utangdata;
  //   List<Mytransutang> mytransutang = this.widget.utangdata;
  //   for (int i = 0; i < mytransutang.length; i++) {
  //     setState(() {
  //       notrans2 = mytransutang[i].notransaksi;
  //       jumlah = mytransutang[i].jumlah;
  //       // bayar1 = myutangjumlah[i].total != null ? myutangjumlah[i].total : 0;
  //     });
  //   }

  //   _getData(notrans2);
  //   super.initState();
  //   print(notrans2);
  // }

  // void _getData(notrans2) async {
  //   // notrans2 = widget.utangdata[i].notransaksi;
  //   List<Myutangjumlah> myutangjumlah = await db.getUtangJumlah(notrans2);
  //   for (int i = 0; i < myutangjumlah.length; i++) {
  //     setState(() {
  //       bayar1 = myutangjumlah[i].total1 != null ? myutangjumlah[i].total1 : 0;
  //       bayar2 = myutangjumlah[i].total1;
  //     });
  //   }

  //   sisa = jumlah - bayar1;
  //   sisautang = sisa != null ? sisa : 0;
  //   // jumlah = sisautang;

  //   print(bayar1);
  //   // print(jumlah);
  // }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: db.getPiutangTotal(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              var piutangtotal = snapshot.data;
              return snapshot.hasData
                  ? new TotalpiutangPage(
                      piutangtotal,
                    )
                  : Center(
                      child: Text(''),
                    );
            },
          ),
          // _tampilan(),
          _listpendom(),
        ],
      ),
    );
  }

  Widget _listpendom() {
    return new Flexible(
        child: new ListView.builder(
      shrinkWrap: true,
      itemCount:
          widget.piutangdata.length == null ? 0 : widget.piutangdata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    new UpdatePiutangPage(widget.piutangdata[i], true)));
          },
          child: Column(
            children: <Widget>[
              Card(
                color: Colors.grey[300],
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Dari : ${widget.piutangdata[i].sumber}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "ID : ${widget.piutangdata[i].notransaksi}",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      widget.piutangdata[i].tipe == "utang" ||
                                              widget.piutangdata[i].tipe ==
                                                  "piutang"
                                          ? "JT : ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse("${widget.piutangdata[i].sortdate}")).toString()}"
                                          : "",
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: widget.piutangdata[i].tipe ==
                                                  "utang"
                                              ? Colors.black
                                              : widget.piutangdata[i].tipe ==
                                                      "piutang"
                                                  ? Colors.black
                                                  : Colors.black),
                                    ),
                                    // Text(widget.piutangdata[i].status3),
                                    // Text(widget.utangdata[i].status),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 1.0, right: 12),
                        child: SingleChildScrollView(
                          child: FutureBuilder(
                            future: db.getPiutangJumlah(
                                // widget.groupdata[i].createdate
                                widget.piutangdata[i].notransaksi),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) print(snapshot.error);
                              var piutangjumlahdata = snapshot.data;
                              return SingleChildScrollView(
                                  child: Piutangjumlah(piutangjumlahdata));
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SingleChildScrollView(
                        child: FutureBuilder(
                          future: db.getTransPiutangBelumLunasreport(
                              // widget.groupdata[i].createdate
                              widget.piutangdata[i].notransaksi),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            var piutangreportdata = snapshot.data;
                            return SingleChildScrollView(
                                child: Semuapiutangdetail(piutangreportdata));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  // Widget _getData(i) {
  //   notrans2 = widget.utangdata[i].notransaksi;

  //   List<Myutangjumlah> myutangjumlah = db.getUtangJumlah(notrans2);
  //   for (int i = 0; i < myutangjumlah.length; i++) {
  //     setState(() {
  //       bayar1 = myutangjumlah[i].total1 != null ? myutangjumlah[i].total1 : 0;
  //     });
  //   }

  //   // sisautang = jumlahutang - bayar1;
  //   // jumlah = sisautang;

  //   print(bayar1);
  //   // print(jumlah);
  // }
}
