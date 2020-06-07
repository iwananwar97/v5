import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mytransgoupdetail.dart';
import 'package:catatan_keuangan/mytransgroup.dart';
import 'package:catatan_keuangan/report/listsemuatransaksi.dart';

import 'package:catatan_keuangan/report/listtransaksireportgroup.dart';

import 'package:flutter/material.dart';

class SemuaTransaksi extends StatefulWidget {
  // final List<Mytransgroup> groupdata;
  // final List<Mytransgroupdetail> groupdatadetail;

  // SemuaTransaksi(this.groupdata, this.groupdatadetail, {Key key});
  _SemuaTransaksiState createState() => _SemuaTransaksiState();
}

class _SemuaTransaksiState extends State<SemuaTransaksi> {
  var db = new TDBHelper();
  var now = DateTime.now();

  Mytransgroup get mytransgroup => null;

  Mytransgroup get mytransgroupdetail => null;

  List<Mytransgroupdetail> get groupdetail => null;

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
      //     body: ListView.builder(
      //   itemBuilder: (context, int i) {
      //     return ListView.builder()
      //   },
      //   itemCount: widget.groupdata.length == null ? 0 : widget.groupdata.length,
      // )

      body: FutureBuilder(
        future: db.getTransGroup(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var groupdata = snapshot.data;
          return snapshot.hasData
              ? new Listsemuatransaksi(
                  groupdata,
                  mytransgroup,
                )
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
