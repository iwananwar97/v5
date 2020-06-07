import 'package:catatan_keuangan/TDBHelper.dart';

import 'package:catatan_keuangan/mytransjmpn.dart';
import 'package:catatan_keuangan/totalutang.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalutangPage extends StatefulWidget {
  final List<Totalutang> utangtotal;

  TotalutangPage(this.utangtotal, {Key key});
  @override
  _TotalutangPageState createState() => _TotalutangPageState();
}

class _TotalutangPageState extends State<TotalutangPage> {
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
    return widget.utangtotal == null
        ? Container()
        : new ListView.builder(
            shrinkWrap: true,
            physics: PageScrollPhysics(),
            itemCount:
                widget.utangtotal.length == null ? 0 : widget.utangtotal.length,
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
                              "Total Utang",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              widget.utangtotal[i].total != null
                                  ? "Rp. ${f.format(widget.utangtotal[i].total).replaceAll(",", ".")}"
                                  : "Rp. 0",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 14),
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
                              widget.utangtotal[i].total1 != null
                                  ? "Rp. ${f.format(widget.utangtotal[i].total1).replaceAll(",", ".")}"
                                  : "Rp. 0",
                              style: TextStyle(color: Colors.red),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: new Divider(
                            height: 2.0,
                            color: Colors.grey[800],
                          ),
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
    if (widget.utangtotal[i].total1 != null ||
        widget.utangtotal[i].total != null) {
      utang =
          widget.utangtotal[i].total != null ? widget.utangtotal[i].total : 0;
      bayar =
          widget.utangtotal[i].total1 != null ? widget.utangtotal[i].total1 : 0;
      sisautang = utang - bayar;
      // if (sisautang != null) {
      return new Text(
        widget.utangtotal[i].total != null ||
                widget.utangtotal[i].total1 != null
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
