import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/tagihan/utang/listutangbelumlunas.dart';
import 'package:catatan_keuangan/tagihan/utang/totalutangPage.dart';
import 'package:catatan_keuangan/totalutang.dart';

import 'package:flutter/material.dart';

class DataUtangPage extends StatefulWidget {
  _DataUtangPageState createState() => _DataUtangPageState();
}

class _DataUtangPageState extends State<DataUtangPage> {
  var db = new TDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // Column(
          //   children: <Widget>[
          // FutureBuilder(
          //   future: db.getUtangTotal(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) print(snapshot.error);
          //     var utangtotal = snapshot.data;
          //     return snapshot.hasData
          //         ? new TotalutangPage(
          //             utangtotal,
          //           )
          //         : Center(
          //             child: Text(''),
          //           );
          //   },
          // ),
          FutureBuilder(
        future: db.getTransUtangBelumLunas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var utangdata = snapshot.data;
          return snapshot.hasData
              ? new Listutangbelumlunas(
                  utangdata,
                )
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
