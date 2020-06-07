import 'package:catatan_keuangan/TDBHelper.dart';


import 'package:catatan_keuangan/mytransgroup.dart';
import 'package:catatan_keuangan/mytransjmpn.dart';


import 'package:catatan_keuangan/report/semuatransaksidetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Listsemuatransaksi extends StatefulWidget {
  final List<Mytransgroup> groupdata;
  

  
  

  final Mytransgroup _mytransgroup;

  Listsemuatransaksi(this.groupdata,this._mytransgroup, {Key key});
  @override
  _ListsemuatransaksiState createState() =>
      _ListsemuatransaksiState();
}

class _ListsemuatransaksiState extends State<Listsemuatransaksi> {
  var f = NumberFormat(
    "#,###",
  );
  var db = new TDBHelper();

  Mytransjmpn mytransjmpn;

  Mytransgroup mytransgroup;
  var date = "";

  // @override
  // void setState(fn) {
  //   date = mytransgroup.createdate;
  //     print(date);
  //   super.setState(fn);
  // }

  // @override
  // void initState() {
  //   if (widget._mytransgroup != null) {
  //     mytransgroup = widget._mytransgroup;
  //     date = mytransgroup.createdate;
  //     print(date);
  //   }

  //   super.initState();
  // }

// List<Mytransgroupdetail> groupdetail;
  

  String nama;
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        // scrollDirection: ,
        itemCount:
            widget.groupdata.length,
        itemBuilder: (BuildContext context, int i) {
          return SingleChildScrollView(
                    child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.purple,
                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                      children: <Widget>[
                        Text(DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString() == "Sunday"
                                ? "Minggu, "
                                : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString() == "Monday"
                                      ? "Senin"
                                      : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString() ==
                                              "Tuesday"
                                          ? "Selasa, "
                                          : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString() ==
                                                  "Wednesday"
                                              ? "Rabu, "
                                              : DateFormat(DateFormat.WEEKDAY)
                                                          .format(DateTime.parse(
                                                              "${widget.groupdata[i].createdate}"))
                                                          .toString() ==
                                                      "Thursday"
                                                  ? "Kamis, "
                                                  : DateFormat(DateFormat.WEEKDAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString() == "Friday"
                                                      ? "Jum'at, "
                                                      : DateFormat(DateFormat.WEEKDAY)
                                                                  .format(DateTime.parse("${widget.groupdata[i].createdate}"))
                                                                  .toString() ==
                                                              "Saturday"
                                                          ? "Sabtu, "
                                                          : "",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                        Text(
                                      "${DateFormat(DateFormat.DAY).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString()} ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                              
                                Text(
                                      "${DateFormat(DateFormat.MONTH).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString()} ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                              
                                Text(
                                      "${DateFormat(DateFormat.YEAR).format(DateTime.parse("${widget.groupdata[i].createdate}")).toString()}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),

                      ],
                    ),
                                    ),
                  ),
                ),

                // ListView.builder(
                //   itemCount: 
                // )
                SingleChildScrollView(
                                  child: FutureBuilder(
            future: db.getTransGroupDetail2(
              // widget.groupdata[i].createdate
                  DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.parse(widget.groupdata[i].createdate))),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              var groupdetail2 = snapshot.data;
              return SingleChildScrollView(child: Semuatransaksidetail(groupdetail2));
                    
            },
        ),
                ),

                
              ],
            ),
          );
        }
        
      ),
    );
    
    // Container(
    //   margin: EdgeInsets.all(10),
    //   child: Column(
    //     children: <Widget>[
    //       // _tampilan(),
    //       _listpendom(),
    //       // _addlist(),
    //     ],
    //   ),
    // );
  }

  var jumlah2;

  Widget _tampilan() {
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("kosongggggg"),
        ],
      ),
    );
  }

  // void jumlah() async {
  //   // var dbClient = await db;

  //   await db.getJumlahPenerimaanHarian();
  //   return;
  //   // return result;
  // }

  
}
