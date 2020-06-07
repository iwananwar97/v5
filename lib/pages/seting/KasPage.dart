import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/pages/seting/AddKasPage.dart';
import 'package:catatan_keuangan/pages/seting/Listkas.dart';

import 'package:catatan_keuangan/pages/seting/katagori/AddKatagoriPenerimaanPage.dart';
import 'package:catatan_keuangan/pages/seting/katagori/listkatagoripenerimaan.dart';

import 'package:flutter/material.dart';

class KasPage extends StatefulWidget {
  _KasPageState createState() => _KasPageState();
}

class _KasPageState extends State<KasPage> {
  var db = new TDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => new AddKasPage(null, true)));
        },
      ),
      body: FutureBuilder(
        future: db.getKas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var kasData = snapshot.data;
          return snapshot.hasData
              ? new Listkas(kasData)
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
