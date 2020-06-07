import 'package:catatan_keuangan/TDBHelper.dart';
import 'package:catatan_keuangan/mytransgroup.dart';
import 'package:catatan_keuangan/report/listtransaksigroupdetail.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransaksiDetailReport extends StatefulWidget {
  TransaksiDetailReport(this._mytransgroup);

  final Mytransgroup _mytransgroup;
  _TransaksiDetailReportState createState() => _TransaksiDetailReportState();
}

class _TransaksiDetailReportState extends State<TransaksiDetailReport> {
  var db = new TDBHelper();
  var now = DateTime.now();

  Mytransgroup mytransgroup;
  var date = "";

  @override
  void initState() {
    if (widget._mytransgroup != null) {
      mytransgroup = widget._mytransgroup;
      date = mytransgroup.createdate;
      print(date);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              
                  Text(DateFormat(DateFormat.WEEKDAY).format(DateTime.parse(date)) == "Sunday"
                      ? "Minggu, "
                      : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse(date)) == "Monday"
                          ? "Senin, "
                          : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse(date)) ==
                                  "Tuesday"
                              ? "Selasa, "
                              : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse(date)) ==
                                      "Wednesday"
                                  ? "Rabu, "
                                  : DateFormat(DateFormat.WEEKDAY)
                                              .format(DateTime.parse(
                                                  date))
                                              .toString() ==
                                          "Thursday"
                                      ? "Kamis, "
                                      : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse(date)) == "Friday"
                                          ? "Jum'at, "
                                          : DateFormat(DateFormat.WEEKDAY)
                                                      .format(DateTime.parse(date))
                                                      .toString() ==
                                                  "Saturday"
                                              ? "Sabtu, "
                                              : "",style: TextStyle(fontSize: 16),),
                                              Text(
                          "${DateFormat(DateFormat.DAY).format(DateTime.parse(date))} ",style: TextStyle(fontSize: 16)),
                    
                      Text(
                          "${DateFormat(DateFormat.MONTH).format(DateTime.parse(date))} ",style: TextStyle(fontSize: 16)),
                    
                      Text(
                          "${DateFormat(DateFormat.YEAR).format(DateTime.parse(date))}",style: TextStyle(fontSize: 16)),// Text(
                  //   " Transaksi Tanggal :",
                  //   style: TextStyle(fontSize: 12),
                  // ),
                  // Text(DateFormat(DateFormat.YEAR_MONTH_DAY)
                  //     .format(DateTime.parse(date))),
               
            ],
          ),
        ),
        backgroundColor: Colors.purple,
      ),
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
        future: db.getTransGroupDetail(
            DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse(date))),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var groupdetail = snapshot.data;
          return 
          
          snapshot.hasData
              ? new Listtransaksigroupdetail(groupdetail)
              : Center(
                  child: Text(''),
                );
        },
      ),
    );
  }
}
