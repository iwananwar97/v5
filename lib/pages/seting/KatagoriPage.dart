import 'package:catatan_keuangan/pages/seting/katagori/KatagoriPenerimaanPage.dart';
import 'package:catatan_keuangan/pages/seting/katagori/KatagoriPengeluaranPage.dart';
import 'package:flutter/material.dart';

class KatagoriPage extends StatefulWidget {
  KatagoriPage(this.colorVal, {Key key}) : super(key: key);

  int colorVal;

  _KatagoriPageState createState() => _KatagoriPageState();
}

class _KatagoriPageState extends State<KatagoriPage>
    with SingleTickerProviderStateMixin {
  //untuk kontrol tab
  TabController _tabController;
  //untuk menandai tab yang aktif
  int tabAktif = 0;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: tabAktif);
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

                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: _tabController.index == 0
                                ? Color(widget.colorVal)
                                : Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Penerimaan',
                        style: TextStyle(
                            color: _tabController.index == 0
                                ? Color(widget.colorVal)
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                Tab(
                  //

                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: _tabController.index == 1
                                ? Color(widget.colorVal)
                                : Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Pengeluaran',
                        style: TextStyle(
                            color: _tabController.index == 1
                                ? Color(widget.colorVal)
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
      // backgroundColor: Colors.grey[300],
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          KatagoriPenerimaanPage(),
          KatagoriPengeluaranPage(),
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
