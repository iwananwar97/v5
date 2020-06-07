import 'package:catatan_keuangan/TDBHelper.dart';

import 'package:catatan_keuangan/mytransjmpn.dart';
import 'package:catatan_keuangan/totalpiutang.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalpiutangPage extends StatefulWidget {
  final List<Totalpiutang> piutangtotal;

  TotalpiutangPage(this.piutangtotal, {Key key});
  @override
  _TotalpiutangPageState createState() => _TotalpiutangPageState();
}

class _TotalpiutangPageState extends State<TotalpiutangPage> {
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
    return widget.piutangtotal == null
        ? Container()
        : new ListView.builder(
            shrinkWrap: true,
            physics: PageScrollPhysics(),
            itemCount: widget.piutangtotal.length == null
                ? 0
                : widget.piutangtotal.length,
            itemBuilder: (BuildContext context, int i) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total Piutang",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              widget.piutangtotal[i].total != null
                                  ? "Rp. ${f.format(widget.piutangtotal[i].total).replaceAll(",", ".")}"
                                  : "Rp. 0",
                              style: TextStyle(
                                  color: Colors.deepOrange, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total Bayar",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              widget.piutangtotal[i].total1 != null
                                  ? "Rp. ${f.format(widget.piutangtotal[i].total1).replaceAll(",", ".")}"
                                  : "Rp. 0",
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total Sisa",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            _getData(i),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // new Divider(
                        //   height: 1.0,
                        //   color: Colors.purple,
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget _getData(i) {
    if (widget.piutangtotal[i].total1 != null ||
        widget.piutangtotal[i].total != null) {
      utang = widget.piutangtotal[i].total != null
          ? widget.piutangtotal[i].total
          : 0;
      bayar = widget.piutangtotal[i].total1 != null
          ? widget.piutangtotal[i].total1
          : 0;
      sisautang = utang - bayar;
      // if (sisautang != null) {
      return new Text(
        widget.piutangtotal[i].total != null ||
                widget.piutangtotal[i].total1 != null
            ? "Rp. ${f.format(sisautang).replaceAll(",", ".")}"
            : 0.toString(),
        style: TextStyle(color: Colors.deepPurple, fontSize: 14),
      );
    } else {
      return new Text(
        "Rp. 0",
        style: TextStyle(color: Colors.deepPurple, fontSize: 14),
      );
    }
  }
}
