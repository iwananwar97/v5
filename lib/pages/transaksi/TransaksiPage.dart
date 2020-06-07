import 'package:catatan_keuangan/pages/transaksi/PenerimaanTransaksiPage.dart';
import 'package:catatan_keuangan/pages/transaksi/RutinPage.dart';
import 'package:catatan_keuangan/tagihan/TagihanPage.dart';

import 'package:flutter/material.dart';

class TransaksiPage extends StatefulWidget {
  TransaksiPage(this.colorVal, {Key key}) : super(key: key);

  int colorVal;

  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage>
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
          height: 40.0,
          child: new TabBar(
              // isScrollable: true,
              indicatorColor: Color(widget.colorVal),
              controller: _tabController,
              tabs: [
                Tab(
                  //
                  child: Text(
                    'Kas',
                    style: TextStyle(
                        color: _tabController.index == 0
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
                Tab(
                  //
                  child: Text(
                    'Tagihan',
                    style: TextStyle(
                        color: _tabController.index == 1
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
                Tab(
                  //
                  child: Text(
                    'Rutin',
                    style: TextStyle(
                        color: _tabController.index == 2
                            ? Color(widget.colorVal)
                            : Colors.black),
                  ),
                ),
                Tab(
                  //
                  child: Text(
                    'Wishlist',
                    style: TextStyle(
                        color: _tabController.index == 3
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
          PenerimaanTransaksiPage(),
          TagihanPage(0xffff5722),
          RutinPage(),
          // RutinPage(0xffff5722),
          // Container(),
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
