import 'package:catatan_keuangan/TDBHelper.dart';

import 'package:catatan_keuangan/tagihan/laporan_utang/listutangreportdata.dart';

import 'package:flutter/material.dart';

class UtangReport extends StatefulWidget {
  _UtangReportState createState() => _UtangReportState();
}

class _UtangReportState extends State<UtangReport> {
  var db = new TDBHelper();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: db.getUtangReport(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var utangreportdata = snapshot.data;
          return snapshot.hasData
              ? new Listutangreportdata(utangreportdata)
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
