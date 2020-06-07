import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/pages/seting/AddPersonPenerimaanPage.dart';

import 'package:catatan_keuangan/pages/seting/katagori/AddKatagoriPenerimaanPage.dart';
import 'package:catatan_keuangan/pages/seting/katagori/listkatagoripenerimaan.dart';
import 'package:catatan_keuangan/pages/seting/listpersonpenerimaan.dart';

import 'package:flutter/material.dart';

class PersonPenerimaanPage extends StatefulWidget {
  _PersonPenerimaanPageState createState() => _PersonPenerimaanPageState();
}

class _PersonPenerimaanPageState extends State<PersonPenerimaanPage> {
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
                  new AddPersonPenerimaanPage(null, true)));
        },
      ),
      body: FutureBuilder(
        future: db.getPersonPenerimaan(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var katpenerimaandata = snapshot.data;
          return snapshot.hasData
              ? new Listpersonpenerimaan(katpenerimaandata)
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
