import 'package:catatan_keuangan/TDBHelper.dart';

import 'package:catatan_keuangan/mytransjmpn.dart';

import 'package:catatan_keuangan/myutangjumlah.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utangjumlah extends StatefulWidget {
  final List<Myutangjumlah> utangjumlahdata;

  Utangjumlah(this.utangjumlahdata, {Key key});
  @override
  _UtangjumlahState createState() => _UtangjumlahState();
}

class _UtangjumlahState extends State<Utangjumlah> {
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
    return widget.utangjumlahdata == null
        ? Container()
        : new ListView.builder(
            shrinkWrap: true,
            physics: PageScrollPhysics(),
            itemCount: widget.utangjumlahdata.length == null
                ? 0
                : widget.utangjumlahdata.length,
            itemBuilder: (BuildContext context, int i) {
              return GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      widget.utangjumlahdata[i].total != null
                          ? "Utang: Rp. ${f.format(widget.utangjumlahdata[i].total).replaceAll(",", ".")}"
                          : "Utang: Rp. 0",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 14),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.utangjumlahdata[i].total1 != null
                          ? "Bayar: Rp. ${f.format(widget.utangjumlahdata[i].total1).replaceAll(",", ".")}"
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
    if (widget.utangjumlahdata[i].total1 != null ||
        widget.utangjumlahdata[i].total != null) {
      utang = widget.utangjumlahdata[i].total != null
          ? widget.utangjumlahdata[i].total
          : 0;
      bayar = widget.utangjumlahdata[i].total1 != null
          ? widget.utangjumlahdata[i].total1
          : 0;
      sisautang = utang - bayar;
      // if (sisautang != null) {
      return new Text(
        widget.utangjumlahdata[i].total != null ||
                widget.utangjumlahdata[i].total1 != null
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
