import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/pages/seting/AddPersonPengeluaranPage.dart';

import 'package:catatan_keuangan/pages/seting/katagori/AddKatagoriPengeluaranPage.dart';

import 'package:catatan_keuangan/pages/seting/katagori/listkatagoripengeluaran.dart';
import 'package:catatan_keuangan/pages/seting/listpersonpengeluaran.dart';

import 'package:flutter/material.dart';

class PersonPengeluaranPage extends StatefulWidget {
  _PersonPengeluaranPageState createState() => _PersonPengeluaranPageState();
}

class _PersonPengeluaranPageState extends State<PersonPengeluaranPage> {
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
                  new AddPersonPengeluaranPage(null, true)));
        },
      ),
      body: FutureBuilder(
        future: db.getPersonPengeluaran(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var katpengeluarandata = snapshot.data;
          return snapshot.hasData
              ? new Listpersonpengeluaran(katpengeluarandata)
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
