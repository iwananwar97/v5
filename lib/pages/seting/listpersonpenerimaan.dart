import 'package:catatan_keuangan/mykatagori.dart';
import 'package:catatan_keuangan/myperson.dart';
import 'package:catatan_keuangan/pages/seting/AddPersonPenerimaanPage.dart';

import 'package:catatan_keuangan/pages/seting/katagori/AddKatagoriPenerimaanPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listpersonpenerimaan extends StatefulWidget {
  final List<Myperson> katpenerimaandata;

  Listpersonpenerimaan(this.katpenerimaandata, {Key key});
  @override
  _ListpersonpenerimaanState createState() => _ListpersonpenerimaanState();
}

class _ListpersonpenerimaanState extends State<Listpersonpenerimaan> {
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
      itemCount: widget.katpenerimaandata.length == null
          ? 0
          : widget.katpenerimaandata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => new AddPersonPenerimaanPage(
                    widget.katpenerimaandata[i], false)));
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  color: Color(0xE5E59AAA),
                  child: ListTile(
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          widget.katpenerimaandata[i].namaKas,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widget.katpenerimaandata[i].noTelp,
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
                          widget.katpenerimaandata[i].kode,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(widget.katpenerimaandata[i].person,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            )),
                        Text(widget.katpenerimaandata[i].alamat,
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
