import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/tagihan/piutang/listpiutangbelumlunas.dart';

import 'package:flutter/material.dart';

class DataPiutangPage extends StatefulWidget {
  _DataPiutangPageState createState() => _DataPiutangPageState();
}

class _DataPiutangPageState extends State<DataPiutangPage> {
  var db = new TDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: db.getTransPiutangBelumLunas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var piutangdata = snapshot.data;
          return snapshot.hasData
              ? new Listpiutangbelumlunas(piutangdata)
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
