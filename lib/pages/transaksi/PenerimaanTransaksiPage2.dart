import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mytrans.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PenerimaanTransaksiPage2 extends StatefulWidget {
  final List<Mytrans> pendomdata;

  PenerimaanTransaksiPage2(this.pendomdata, {Key key});
  _PenerimaanTransaksiPage2State createState() =>
      _PenerimaanTransaksiPage2State();
}

class _PenerimaanTransaksiPage2State extends State<PenerimaanTransaksiPage2> {
  var db = new TDBHelper();
  var now = DateTime.now();
  var f = NumberFormat(
    "#,###",
  );

  // void getData() async {
  //   var pendomdata = await db.getTrans();

  //   if(pendomdata!=null){
  //     final List<Mytrans> pendomdata;

  //     // return pendomdata.toList();
  //   }

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.blue,
        //   child: Icon(
        //     Icons.add,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             new AddPenerimaanDomPage(null, true)));
        //   },
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Flexible(
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
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[1000],
                child: Icon(
                  widget.pendomdata[i].rek == "dompet"
                      ? Icons.style
                      : Icons.atm,
                  color: Colors.white,
                ),
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // Text(widget.pendomdata[i].rek),

                  // Text(
                  //   widget.pendomdata[i].katagori,
                  //   style: TextStyle(fontSize: 10),
                  // ),
                  Text(
                    widget.pendomdata[i].rek,
                    style: TextStyle(fontSize: 14),
                  ),
                  // Text(
                  //     "${int.parse(widget.pendomdata[i].jumlah) + int.parse(widget.pendomdata[i].jumlah)}"),
                  // widget.pendomdata[i].rek,
                  // style: TextStyle(fontSize: 14),

                  // Text(nama),
                  Text(
                    "Rp. ${f.format(widget.pendomdata[i].jumlah).replaceAll(",", ".")}",
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.pendomdata[i].jenis == "penerimaan"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),

                  Text(
                    widget.pendomdata[i].tipe,
                    style: TextStyle(
                        fontSize: 8,
                        color: widget.pendomdata[i].tipe == "utang"
                            ? Colors.red
                            : widget.pendomdata[i].tipe == "piutang"
                                ? Colors.green
                                : Colors.white),
                  ),
                  Text(
                    widget.pendomdata[i].tipe == "utang" ||
                            widget.pendomdata[i].tipe == "piutang"
                        ? "Jatuh Tempo: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse("${widget.pendomdata[i].sortdate}")).toString()}"
                        : "",
                    style: TextStyle(
                        fontSize: 8,
                        color: widget.pendomdata[i].tipe == "utang"
                            ? Colors.red
                            : widget.pendomdata[i].tipe == "piutang"
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
                    "${widget.pendomdata[i].jenis == "penerimaan" ? "Dari" : "Untuk"} : ${widget.pendomdata[i].sumber}",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    widget.pendomdata[i].katagori,
                    style: TextStyle(
                        fontSize: 12,
                        color: widget.pendomdata[i].status == "Bayar Utang"
                            ? Colors.red
                            : widget.pendomdata[i].status == "Bayar Piutang"
                                ? Colors.green
                                : Colors.black),
                  ),
                  Text(
                    widget.pendomdata[i].jenis,
                    style: TextStyle(
                        fontSize: 12,
                        color: widget.pendomdata[i].jenis == "pengeluaran"
                            ? Colors.redAccent
                            : Colors.green),
                  ),
                  // notransaksi(i),

                  // Text(widget.pendomdata[i].id.toString())
                ],
              ),
              subtitle: Text(
                "${widget.pendomdata[i].ket}",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
        );
      },
    )));
  }
}
