import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mykatagori.dart';

import 'package:catatan_keuangan/mytransgoupdetail.dart';
import 'package:catatan_keuangan/mytransjmpn.dart';

import 'package:catatan_keuangan/pages/transaksi/AddTransaksiPage.dart';
import 'package:catatan_keuangan/report/Editdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listtransaksigroupdetail extends StatefulWidget {
  final List<Mytransgroupdetail> groupdetail;

  Listtransaksigroupdetail(this.groupdetail, {Key key});
  @override
  _ListtransaksigroupdetailState createState() =>
      _ListtransaksigroupdetailState();
}

class _ListtransaksigroupdetailState extends State<Listtransaksigroupdetail> {
  var f = NumberFormat(
    "#,###",
  );
  var db = new TDBHelper();

  Mytransjmpn mytransjmpn;

  // List<Mytransjmpn> total;

  String nama;
  // int _jumlah;
  // List jumlah1;

  // int _total = 0;
  // List priceList;

  // _calcTotal();

  // void _calcTotal() async {
  //   priceList = await db.calculateTotal();
  //   priceList.forEach((jumlah) {
  //     _total = _total + jumlah['jumlah'];
  //   });
  //   print(_total);

  // }

  // void _calcTotal() async {
  //   var total = (await db.getJumlahPenerimaanHarian())[0]['Total'];
  //   print(total);
  //   //   // jumlah1 = await db.getJumlahPenerimaanHarian();
  //   //   // jumlah1.forEach((jumlah) {
  //   //   //   _jumlah = _jumlah + jumlah['jumlah'];
  //   //   // });
  //   //   // print(_jumlah);
  //   //   setState(() => _jumlah = total);
  // }

  // @override
  // void initState() {
  //   _calcTotal();
  //   super.initState();
  // }
  // nama2();

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _tampilan(),
          _listpendom(),
          // _addlist(),
        ],
      ),
    );
  }

  var jumlah2;

  Widget _tampilan() {
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("kosongggggg"),
        ],
      ),
    );
  }

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
      itemCount:
          widget.groupdetail.length == null ? 0 : widget.groupdetail.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    new Editdetail(widget.groupdetail[i], false)));
          },
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[1000],
                child: Icon(
                  widget.groupdetail[i].rek == "dompet"
                      ? Icons.style
                      : Icons.atm,
                  color: Colors.white,
                ),
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(widget.groupdetail[i].rek),

                  // Text(widget.groupdetail[i].katagori),
                  // Text(nama),
                  Text(
                    "Rp. ${f.format(widget.groupdetail[i].jumlah).replaceAll(",", ".")}",
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.groupdetail[i].jenis == "penerimaan"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  Text(
                    widget.groupdetail[i].tipe,
                    style: TextStyle(
                        fontSize: 8,
                        color: widget.groupdetail[i].tipe == "utang"
                            ? Colors.red
                            : widget.groupdetail[i].tipe == "piutang"
                                ? Colors.green
                                : Colors.white),
                  ),
                  Text(
                    widget.groupdetail[i].tipe == "utang" ||
                            widget.groupdetail[i].tipe == "piutang"
                        ? "Jatuh Tempo: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse("${widget.groupdetail[i].sortdate}")).toString()}"
                        : "",
                    style: TextStyle(
                        fontSize: 8,
                        color: widget.groupdetail[i].tipe == "utang"
                            ? Colors.red
                            : widget.groupdetail[i].tipe == "piutang"
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
                    "${widget.groupdetail[i].jenis == "penerimaan" ? "Dari" : "Untuk"} : ${widget.groupdetail[i].sumber}",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    widget.groupdetail[i].katagori,
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    widget.groupdetail[i].jenis,
                    style: TextStyle(
                        fontSize: 12,
                        color: widget.groupdetail[i].jenis == "pengeluaran"
                            ? Colors.redAccent
                            : Colors.green),
                  ),
                  // Text("${widget.groupdetail[i].notransaksi}")
                ],
              ),
              subtitle: Text(
                "${widget.groupdetail[i].ket}",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
        );
      },
    ));
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
    Mykatagori mykatagori = await db.getById(widget.groupdetail[i]);
    nama = mykatagori.nama != null ? mykatagori.nama : "";
  }
}
