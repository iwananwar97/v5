import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mypiutangjumlah.dart';

import 'package:catatan_keuangan/mytransjmpn.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Piutangjumlah extends StatefulWidget {
  final List<Mypiutangjumlah> piutangjumlahdata;

  Piutangjumlah(this.piutangjumlahdata, {Key key});
  @override
  _PiutangjumlahState createState() => _PiutangjumlahState();
}

class _PiutangjumlahState extends State<Piutangjumlah> {
  var f = NumberFormat(
    "#,###",
  );
  var db = new TDBHelper();

  Mytransjmpn mytransjmpn;
  int sisautang, utang, bayar;

  // List<Mytransjmpn> total;

  String nama;

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   sisautang=int.parse(utangdata[i].)
    // });
    return widget.piutangjumlahdata == null
        ? Container()
        : new ListView.builder(
            shrinkWrap: true,
            physics: PageScrollPhysics(),
            itemCount: widget.piutangjumlahdata.length == null
                ? 0
                : widget.piutangjumlahdata.length,
            itemBuilder: (BuildContext context, int i) {
              return GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      widget.piutangjumlahdata[i].total != null
                          ? "Piutang: Rp. ${f.format(widget.piutangjumlahdata[i].total).replaceAll(",", ".")}"
                          : "Piutang: Rp. 0",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.piutangjumlahdata[i].total1 != null
                          ? "Bayar: Rp. ${f.format(widget.piutangjumlahdata[i].total1).replaceAll(",", ".")}"
                          : "Bayar: Rp. 0",
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _getData(i),
                    SizedBox(
                      height: 5,
                    ),
                    // new Divider(
                    //   height: 1.0,
                    //   color: Colors.purple,
                    // ),
                  ],
                ),
              );
            },
          );
  }

  Widget _getData(i) {
    if (widget.piutangjumlahdata[i].total1 != null ||
        widget.piutangjumlahdata[i].total != null) {
      utang = widget.piutangjumlahdata[i].total != null
          ? widget.piutangjumlahdata[i].total
          : 0;
      bayar = widget.piutangjumlahdata[i].total1 != null
          ? widget.piutangjumlahdata[i].total1
          : 0;
      sisautang = utang - bayar;
      // if (sisautang != null) {
      return new Text(
        widget.piutangjumlahdata[i].total != null ||
                widget.piutangjumlahdata[i].total1 != null
            ? "Sisa: Rp. ${f.format(sisautang).replaceAll(",", ".")}"
            : 0.toString(),
        style: TextStyle(color: Colors.deepPurple),
      );
    } else {
      return new Text(
        "Sisa: Rp. 0",
        style: TextStyle(color: Colors.deepPurple),
      );
    }
  }
}
