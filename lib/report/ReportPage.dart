import 'package:catatan_keuangan/report/SemuaTransaksi.dart';
import 'package:catatan_keuangan/report/TransaksiReport.dart';
import 'package:catatan_keuangan/tagihan/TagihanPage.dart';

import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  ReportPage(this.colorVal, {Key key}) : super(key: key);

  int colorVal;

  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>
    with SingleTickerProviderStateMixin {
  //untuk kontrol tab
  TabController _tabController;
  //untuk menandai tab yang aktif
  int tabAktif = 0;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 6, vsync: this, initialIndex: tabAktif);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      widget.colorVal = 0xffff5722;
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: new Container(
          height: 40.0,
          child: new TabBar(
              isScrollable: true,
              indicatorColor: Color(widget.colorVal),
              controller: _tabController,
              tabs: [
                Tab(
                  //
                  child: Text(
                    'Transaksi Per Tanggal',
                    style: TextStyle(
                        color: _tabController.index == 0
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
                Tab(
                  //
                  child: Text(
                    'Semua Transaksi',
                    style: TextStyle(
                        color: _tabController.index == 1
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
                Tab(
                  //
                  child: Text(
                    'Piutang',
                    style: TextStyle(
                        color: _tabController.index == 2
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
                Tab(
                  //
                  child: Text(
                    'data',
                    style: TextStyle(
                        color: _tabController.index == 3
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
                Tab(
                  //
                  child: Text(
                    'data',
                    style: TextStyle(
                        color: _tabController.index == 4
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
                Tab(
                  //
                  child: Text(
                    'data',
                    style: TextStyle(
                        color: _tabController.index == 5
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
              ]),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          TransaksiReport(),
          SemuaTransaksi(),
          TagihanPage(0xffff5722),
          Container(),
          Container(),
          Container(),
          // BankPage(0xffff5722),
        ],
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return new Scaffold(
  //       appBar: AppBar(
  //           // title: Text('Catatan Keuangan'),

  //           backgroundColor: Colors.grey[200],
  //           bottom: TabBar(
  //             labelPadding: EdgeInsets.all(0), //untuk judul tabnya
  //             controller: _tabController,
  //             unselectedLabelColor: Colors.black,
  //             tabs: <Tab>[
  //               Tab(
  //                 icon: Icon(Icons.trending_up,
  //                     color: _tabController.index == 0
  //                         ? Color(widget.colorVal)
  //                         : Colors.black),

  //                 child: Text(
  //                   'Penerimaan',
  //                   style: TextStyle(
  //                       color: _tabController.index == 0
  //                           ? Color(widget.colorVal)
  //                           : Colors.black),
  //                 ),
  //                 // text: "Penerimaan",
  //               ),
  //               Tab(
  //                 icon: Icon(Icons.trending_down,
  //                     color: _tabController.index == 1
  //                         ? Color(widget.colorVal)
  //                         : Colors.black),

  //                 child: Text(
  //                   'Pengeluaran',
  //                   style: TextStyle(
  //                       color: _tabController.index == 1
  //                           ? Color(widget.colorVal)
  //                           : Colors.black),
  //                 ),
  //                 // text: "Penerimaan",
  //               ),
  //             ],
  //           )),
  //       //backgroundColor: Colors.blueAccent,
  //       body: TabBarView(
  //         controller: _tabController,
  //         children: <Widget>[
  //           PengeluaranPage(),
  //           //Container(color: Colors.red,),
  //           Container(
  //             color: Colors.teal,
  //           ),
  //         ],
  //       ));
  // }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
