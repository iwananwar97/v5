import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/pages/transaksi/listtransaksi.dart';

import 'package:flutter/material.dart';

class PenerimaanTransaksiPage extends StatefulWidget {
  _PenerimaanTransaksiPageState createState() =>
      _PenerimaanTransaksiPageState();
}

class _PenerimaanTransaksiPageState extends State<PenerimaanTransaksiPage> {
  var db = new TDBHelper();
  var now = DateTime.now();

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
      body: FutureBuilder(
        future: db.getTrans(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var notedata = snapshot.data;
          return snapshot.hasData
              ? new Listtransaksi(notedata)
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
