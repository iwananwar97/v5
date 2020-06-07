import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/pages/transaksi/listrutin.dart';
import 'package:catatan_keuangan/pages/transaksi/listtransaksi.dart';

import 'package:flutter/material.dart';

class RutinPage extends StatefulWidget {
  _RutinPageState createState() => _RutinPageState();
}

class _RutinPageState extends State<RutinPage> {
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
        future: db.getRutin(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var rutindata = snapshot.data;
          return snapshot.hasData
              ? new Listrutin(rutindata)
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
