import 'package:catatan_keuangan/TDBHelper.dart';

import 'package:catatan_keuangan/report/listtransaksireportgroup.dart';

import 'package:flutter/material.dart';

class TransaksiReport extends StatefulWidget {
  _TransaksiReportState createState() => _TransaksiReportState();
}

class _TransaksiReportState extends State<TransaksiReport> {
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
        future: db.getTransGroup(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var groupdata = snapshot.data;
          return snapshot.hasData
              ? new Listtransaksireportgroup(groupdata)
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
