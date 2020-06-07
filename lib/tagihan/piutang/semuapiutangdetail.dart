import 'package:catatan_keuangan/TDBHelper.dart';


import 'package:catatan_keuangan/mytransjmpn.dart';
import 'package:catatan_keuangan/mytranspiutangbelumlunas.dart';

import 'package:catatan_keuangan/tagihan/piutang/UpdatePiutangDetail.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Semuapiutangdetail extends StatefulWidget {
  final List<Mytranspiutangbelumlunas> piutangreportdata;

  Semuapiutangdetail(this.piutangreportdata, {Key key});
  @override
  _SemuapiutangdetailState createState() => _SemuapiutangdetailState();
}

class _SemuapiutangdetailState extends State<Semuapiutangdetail> {
  var f = NumberFormat(
    "#,###",
  );
  var db = new TDBHelper();

  Mytransjmpn mytransjmpn;

  // List<Mytransjmpn> total;

  String nama;

  @override
  Widget build(BuildContext context) {
    return widget.piutangreportdata == null
        ? Container()
        : new ListView.builder(
            shrinkWrap: true,
            physics: PageScrollPhysics(),
            itemBuilder: (context, int i) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new UpdatePiutangDetail(
                              widget.piutangreportdata[i], true)));
                },
                child: SingleChildScrollView(
                  child: Card(
                    color: Colors.grey[400],
                    // Color(0xE5E59AAA),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                    height: 30,
                                    width: 30,
                                    // color: Color(0xA5A51140),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        // shape: ,
                                        border: Border.all(
                                          color: Colors.grey[400],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 6, bottom: 6),
                                      child: Text(
                                        "${widget.piutangreportdata[i].urutanbayar}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Dari Kas : ${widget.piutangreportdata[i].rek}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Tanggal : ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse("${widget.piutangreportdata[i].updatedate}"))}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                // Text(""),
                                Text(
                                  "Rp. ${f.format(widget.piutangreportdata[i].jumlah).replaceAll(",", ".")}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: widget.piutangreportdata.length == null
                ? 0
                : widget.piutangreportdata.length,
          );
  }
}
