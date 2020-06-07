import 'package:catatan_keuangan/mykas.dart';
import 'package:catatan_keuangan/pages/seting/AddKasPage.dart';

import 'package:catatan_keuangan/pages/seting/katagori/AddKatagoriPenerimaanPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listkas extends StatefulWidget {
  final List<Mykas> kasData;

  Listkas(this.kasData, {Key key});
  @override
  _ListkasState createState() => _ListkasState();
}

class _ListkasState extends State<Listkas> {
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
      itemCount: widget.kasData.length == null ? 0 : widget.kasData.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    new AddKasPage(widget.kasData[i], false)));
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                Card(
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.kasData[i].kas,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // child: Container(
          //   height: 50,
          //   child: Card(
          //     color: Colors.white,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         // width: double.infinity,
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text(
          //             widget.pendomdata[i].sumber,
          //             style: TextStyle(
          //                 fontSize: 12.0, fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //         // Text(widget.pendomdata[i].katagori),
          //         // Text(widget.pendomdata[i].jenis),
          //         // Text(widget.pendomdata[i].tipe),
          //         // Text(widget.pendomdata[i].status),
          //         // // Text(widget.pendomdata[i].jatuhtempodate),
          //         // Expanded(
          //         //   child: SingleChildScrollView(
          //         //     child: Container(
          //         //       padding: const EdgeInsets.all(8.0),
          //         //       child: Text(
          //         //         widget.pendomdata[i].jumlah,
          //         //         style: TextStyle(fontSize: 16.0),
          //         //       ),
          //         //     ),
          //         //   ),
          //         // ),
          //         // Divider(
          //         //   color: Colors.grey,
          //         // ),
          //         // Text("Created:${widget.pendomdata[i].createdate}"),
          //         // Text("Updated:${widget.pendomdata[i].updatedate}"),
          //       ],
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}
