import 'package:catatan_keuangan/mytrans.dart';

import 'package:flutter/material.dart';

class Listdatatabel extends StatefulWidget {
  final List<Mytrans> pendomdata;

  Listdatatabel(this.pendomdata, {Key key});
  @override
  _ListdatatabelState createState() => _ListdatatabelState();
}

class _ListdatatabelState extends State<Listdatatabel> {
  DataTable databody() {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            "Sumber",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          tooltip: "data",
        ),
        DataColumn(
          label: Text(
            "Katagori",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          tooltip: "data",
        ),
        DataColumn(
          label: Text(
            "Jumlah",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          tooltip: "data",
        ),
      ],
      rows: widget.pendomdata
          .map(
            (data) => DataRow(cells: [
              DataCell(
                Text(data.sumber),
              ),
              DataCell(
                Text(data.katagori),
              ),
              DataCell(
                Text(
                  data.jumlah.toString(),
                  textAlign: TextAlign.right,
                ),
              ),
            ]),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(child: databody()),
          ),
        ],
      ),
    );
    // GridView.builder(
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount:
    //           MediaQuery.of(context).orientation == Orientation.portrait
    //               ? 1
    //               : 1),
    //   itemCount:
    //       widget.pendomdata.length == null ? 0 : widget.pendomdata.length,
    //   itemBuilder: (BuildContext context, int i) {
    //     return GestureDetector(
    //         onTap: () {
    //           Navigator.of(context).push(MaterialPageRoute(
    //               builder: (BuildContext context) =>
    //                   new AddPenerimaanDomPage(widget.pendomdata[i], false)));
    //         },
    //         child: Center(
    //           child: databody(),

    // Card(
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: <Widget>[
    //         Text(widget.pendomdata[i].sumber),
    //         Text(widget.pendomdata[i].katagori),
    //         Text(widget.pendomdata[i].jumlah),
    //       ],
    //     ),
    //   ),
    // ),
  }
}
