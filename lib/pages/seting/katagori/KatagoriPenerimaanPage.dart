import 'package:catatan_keuangan/TDBHelper.dart';

import 'package:catatan_keuangan/pages/seting/katagori/AddKatagoriPenerimaanPage.dart';
import 'package:catatan_keuangan/pages/seting/katagori/listkatagoripenerimaan.dart';

import 'package:flutter/material.dart';

class KatagoriPenerimaanPage extends StatefulWidget {
  _KatagoriPenerimaanPageState createState() => _KatagoriPenerimaanPageState();
}

class _KatagoriPenerimaanPageState extends State<KatagoriPenerimaanPage> {
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
              builder: (BuildContext context) =>
                  new AddKatagoriPenerimaanPage(null, true)));
        },
      ),
      body: FutureBuilder(
        future: db.getKatagoriPenerimaan(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var katpendata = snapshot.data;
          return snapshot.hasData
              ? new Listkatagoripenerimaan(katpendata)
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
