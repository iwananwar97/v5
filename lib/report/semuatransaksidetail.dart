import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mykatagori.dart';

import 'package:catatan_keuangan/mytransgoupdetail.dart';
import 'package:catatan_keuangan/mytransjmpn.dart';

import 'package:catatan_keuangan/pages/transaksi/AddTransaksiPage.dart';
import 'package:catatan_keuangan/report/EditSemuaTransaksi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Semuatransaksidetail extends StatefulWidget {
  final List<Mytransgroupdetail> groupdetail2;

  Semuatransaksidetail(this.groupdetail2, {Key key});
  @override
  _SemuatransaksidetailState createState() => _SemuatransaksidetailState();
}

class _SemuatransaksidetailState extends State<Semuatransaksidetail> {
  var f = NumberFormat(
    "#,###",
  );
  var db = new TDBHelper();

  Mytransjmpn mytransjmpn;

  // List<Mytransjmpn> total;

  String nama;

  @override
  Widget build(BuildContext context) {
    return widget.groupdetail2 == null
        ? Container()
        : new ListView.builder(
            shrinkWrap: true,
            physics: PageScrollPhysics(),
            itemBuilder: (context, int i) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => new EditSemuaTransaksi(
                          widget.groupdetail2[i], false)));
                },
                child: SingleChildScrollView(
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[1000],
                        child: Icon(
                          widget.groupdetail2[i].rek == "dompet"
                              ? Icons.style
                              : Icons.atm,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          // Text(widget.groupdetail2[i].rek),

                          Text(widget.groupdetail2[i].katagori),
                          // Text(nama),
                          Text(
                            "Rp. ${f.format(widget.groupdetail2[i].jumlah).replaceAll(",", ".")}",
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  widget.groupdetail2[i].jenis == "penerimaan"
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                          Text(
                            widget.groupdetail2[i].tipe,
                            style: TextStyle(
                                fontSize: 8,
                                color: widget.groupdetail2[i].tipe == "utang"
                                    ? Colors.red
                                    : widget.groupdetail2[i].tipe == "piutang"
                                        ? Colors.green
                                        : Colors.white),
                          ),
                          Text(
                            widget.groupdetail2[i].tipe == "utang" ||
                                    widget.groupdetail2[i].tipe == "piutang"
                                ? "Jatuh Tempo: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse("${widget.groupdetail2[i].sortdate}")).toString()}"
                                : "",
                            style: TextStyle(
                                fontSize: 8,
                                color: widget.groupdetail2[i].tipe == "utang"
                                    ? Colors.red
                                    : widget.groupdetail2[i].tipe == "piutang"
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
                            "Dari : ${widget.groupdetail2[i].sumber}",
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            widget.groupdetail2[i].jenis,
                            style: TextStyle(
                                fontSize: 12,
                                color: widget.groupdetail2[i].jenis ==
                                        "pengeluaran"
                                    ? Colors.redAccent
                                    : Colors.green),
                          ),
                          // Text("${widget.groupdetail2[i].notransaksi}")
                        ],
                      ),
                      subtitle: Text(
                        "${widget.groupdetail2[i].ket}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: widget.groupdetail2.length == null
                ? 0
                : widget.groupdetail2.length,
          );
  }

  var jumlah2;

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
    Mykatagori mykatagori = await db.getById(widget.groupdetail2[i]);
    nama = mykatagori.nama != null ? mykatagori.nama : "";
  }
}
