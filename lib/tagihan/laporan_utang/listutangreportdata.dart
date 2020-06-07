import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mykatagori.dart';

import 'package:catatan_keuangan/mytransjmpn.dart';
import 'package:catatan_keuangan/myutangpiutang.dart';
import 'package:catatan_keuangan/myutangpiutanglist.dart';
import 'package:catatan_keuangan/myutangreport.dart';

import 'package:catatan_keuangan/pages/transaksi/AddTransaksiPage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listutangreportdata extends StatefulWidget {
  final List<Myutangreport> utangreportdata;

  Listutangreportdata(this.utangreportdata, {Key key});
  @override
  _ListutangreportdataState createState() => _ListutangreportdataState();
}

class _ListutangreportdataState extends State<Listutangreportdata> {
  var f = NumberFormat(
    "#,###",
  );
  var db = new TDBHelper();

  Mytransjmpn mytransjmpn;

  String nama;

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
      itemCount: widget.utangreportdata.length == null
          ? 0
          : widget.utangreportdata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          // onTap: () {
          //   Navigator.of(context).push(MaterialPageRoute(
          //       builder: (BuildContext context) =>
          //           new UtangDetailReport(widget.utangreportdata[i])));
          // },
          child: Card(
            color: Colors.grey[200],
            child: ListTile(
              // isThreeLine: true,

              // leading: CircleAvatar(
              //   backgroundColor: Colors.grey[1000],
              //   // child: Icon(
              //   //   widget.utangreportdata[i].rek == "dompet" ? Icons.style : Icons.atm,
              //   //   color: Colors.white,
              //   // ),
              // ),

              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[],
              ),
              title: Container(
                // color: Colors.blue,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.utangreportdata[i].sumber),
                    // Text(DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.utangreportdata[i].createdate}")).toString() == "Sunday"
                    //     ? "Minggu,"
                    //     : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.utangreportdata[i].createdate}")).toString() == "Monday"
                    //         ? "Senin"
                    //         : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.utangreportdata[i].createdate}")).toString() ==
                    //                 "Tuesday"
                    //             ? "Selasa,"
                    //             : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.utangreportdata[i].createdate}")).toString() ==
                    //                     "Wednesday"
                    //                 ? "Rabu,"
                    //                 : DateFormat(DateFormat.WEEKDAY)
                    //                             .format(DateTime.parse(
                    //                                 "${widget.utangreportdata[i].createdate}"))
                    //                             .toString() ==
                    //                         "Thursday"
                    //                     ? "Kamis,"
                    //                     : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.utangreportdata[i].createdate}")).toString() == "Friday"
                    //                         ? "Jum'at,"
                    //                         : DateFormat(DateFormat.WEEKDAY)
                    //                                     .format(DateTime.parse("${widget.utangreportdata[i].createdate}"))
                    //                                     .toString() ==
                    //                                 "Saturday"
                    //                             ? "Sabtu,"
                    //                             : "",style: TextStyle(fontSize: 14),),
                    // Row(
                    //   children: <Widget>[
                    //     Text(
                    //         "${DateFormat(DateFormat.DAY).format(DateTime.parse("${widget.utangreportdata[i].createdate}")).toString()} ",style: TextStyle(fontSize: 14)),

                    //     Text(
                    //         "${DateFormat(DateFormat.MONTH).format(DateTime.parse("${widget.utangreportdata[i].createdate}")).toString()} ",style: TextStyle(fontSize: 14)),

                    //     Text(
                    //         "${DateFormat(DateFormat.YEAR).format(DateTime.parse("${widget.utangreportdata[i].createdate}")).toString()}",style: TextStyle(fontSize: 14)),
                    //   ],
                    // )
                  ],
                ),
              ),
              subtitle: Text("TEXT"),
              // isThreeLine: true,
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
    Mykatagori mykatagori = await db.getById(widget.utangreportdata[i]);
    nama = mykatagori.nama != null ? mykatagori.nama : "";
  }
}
