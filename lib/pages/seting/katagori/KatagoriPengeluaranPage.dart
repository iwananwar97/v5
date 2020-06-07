import 'package:catatan_keuangan/TDBHelper.dart';

import 'package:catatan_keuangan/pages/seting/katagori/AddKatagoriPengeluaranPage.dart';

import 'package:catatan_keuangan/pages/seting/katagori/listkatagoripengeluaran.dart';

import 'package:flutter/material.dart';

class KatagoriPengeluaranPage extends StatefulWidget {
  _KatagoriPengeluaranPageState createState() =>
      _KatagoriPengeluaranPageState();
}

class _KatagoriPengeluaranPageState extends State<KatagoriPengeluaranPage> {
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
                  new AddKatagoriPengeluaranPage(null, true)));
        },
      ),
      body: FutureBuilder(
        future: db.getKatagoriPengeluaran(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var katpengeluarandata = snapshot.data;
          return snapshot.hasData
              ? new Listkatagoripengeluaran(katpengeluarandata)
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
