import 'package:catatan_keuangan/mykatagori.dart';
import 'package:catatan_keuangan/myperson.dart';
import 'package:catatan_keuangan/pages/seting/AddPersonPenerimaanPage.dart';
import 'package:catatan_keuangan/pages/seting/AddPersonPengeluaranPage.dart';

import 'package:catatan_keuangan/pages/seting/katagori/AddKatagoriPenerimaanPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listpersonpengeluaran extends StatefulWidget {
  final List<Myperson> katpengeluarandata;

  Listpersonpengeluaran(this.katpengeluarandata, {Key key});
  @override
  _ListpersonpengeluaranState createState() => _ListpersonpengeluaranState();
}

class _ListpersonpengeluaranState extends State<Listpersonpengeluaran> {
  var f = NumberFormat('###.0#', 'en_US');
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,

      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount:
      //         MediaQuery.of(context).orientation == Orientation.portrait
      //             ? 1
      //             : 1),
      itemCount: widget.katpengeluarandata.length == null
          ? 0
          : widget.katpengeluarandata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => new AddPersonPengeluaranPage(
                    widget.katpengeluarandata[i], false)));
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  color: Color(0xB3B3c8E6),
                  child: ListTile(
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.katpengeluarandata[i].namaKas,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widget.katpengeluarandata[i].noTelp,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.katpengeluarandata[i].kode,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(widget.katpengeluarandata[i].person,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            )),
                        Text(widget.katpengeluarandata[i].alamat,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
