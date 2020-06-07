import 'package:catatan_keuangan/pages/seting/SetingPage.dart';
import 'package:catatan_keuangan/pages/transaksi/TransaksiPage.dart';
import 'package:catatan_keuangan/report/reportPage.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //untuk kontrol tab
  TabController _tabController;
  //untuk menandai tab yang aktif
  int tabAktif = 0;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: tabAktif);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Catatan Keuangan'),
            bottom: new TabBar(
              labelPadding: EdgeInsets.all(0), //untuk judul tabnya
              controller: _tabController,
              tabs: <Tab>[
                Tab(
                  text: "Transaksi",
                ),
                Tab(
                  text: "Report",
                ),
                Tab(
                  text: "Setting",
                ),
              ],
            )),
        //backgroundColor: Colors.blueAccent,
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            TransaksiPage(0xffff5722),
            //Container(color: Colors.red,),
            ReportPage(0xffff5722),

            SetingPage(0xffff5722),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
