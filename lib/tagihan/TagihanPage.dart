import 'package:catatan_keuangan/tagihan/laporan_utang/UtangReport.dart';
import 'package:catatan_keuangan/tagihan/piutang/DataPiutangPage.dart';
import 'package:catatan_keuangan/tagihan/utang/DataUtangPage.dart';
import 'package:flutter/material.dart';

class TagihanPage extends StatefulWidget {
  TagihanPage(this.colorVal, {Key key}) : super(key: key);

  int colorVal;

  _TagihanPageState createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage>
    with SingleTickerProviderStateMixin {
  //untuk kontrol tab
  TabController _tabController;
  //untuk menandai tab yang aktif
  int tabAktif = 0;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this, initialIndex: tabAktif);
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
          color: Colors.grey[100],
          height: 50.0,
          child: new TabBar(
              controller: _tabController,
              indicatorColor: (Colors.white),
              tabs: [
                Tab(
                  //

                  child: Text(
                    'Utang',
                    style: TextStyle(
                        color: _tabController.index == 0
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
                Tab(
                  //

                  child: Text(
                    'Piutang',
                    style: TextStyle(
                        color: _tabController.index == 1
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
                Tab(
                  //

                  child: Text(
                    'Laporan Utang',
                    style: TextStyle(
                        color: _tabController.index == 2
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
                Tab(
                  //

                  child: Text(
                    'Laporan Piutang',
                    style: TextStyle(
                        color: _tabController.index == 3
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
              ]),
        ),
      ),
      // backgroundColor: Colors.grey[300],
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          DataUtangPage(),
          DataPiutangPage(),
          UtangReport(),
          Container(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}
