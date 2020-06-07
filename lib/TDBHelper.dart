import 'package:catatan_keuangan/myperson.dart';
import 'package:catatan_keuangan/mypiutangjumlah.dart';
import 'package:catatan_keuangan/myrutin.dart';
import 'package:catatan_keuangan/mytrans2.dart';
import 'package:catatan_keuangan/mytrans3.dart';
import 'package:catatan_keuangan/mytrans4.dart';
import 'package:catatan_keuangan/mytrans5.dart';
import 'package:catatan_keuangan/mytrans6.dart';
import 'package:catatan_keuangan/mytransdetail.dart';
import 'package:catatan_keuangan/mytransgoupdetail.dart';
import 'package:catatan_keuangan/mytransgroup.dart';
import 'package:catatan_keuangan/mytransjmpn.dart';
import 'package:catatan_keuangan/mytransjumlah.dart';
import 'package:catatan_keuangan/mytransjumlahgroup.dart';
import 'package:catatan_keuangan/mytransjumlahgroupharian.dart';
import 'package:catatan_keuangan/mytranspiutang.dart';
import 'package:catatan_keuangan/mytranspiutangbelumlunas.dart';
import 'package:catatan_keuangan/mykas.dart';
import 'package:catatan_keuangan/mytransstatus.dart';
import 'package:catatan_keuangan/mytransstatus3.dart';
import 'package:catatan_keuangan/mytransurutan.dart';
import 'package:catatan_keuangan/mytransutang.dart';
import 'package:catatan_keuangan/mytransutangbelumlunas.dart';
import 'package:catatan_keuangan/myutangjumlah.dart';
import 'package:catatan_keuangan/myutangjumlah2.dart';
import 'package:catatan_keuangan/myutangpiutang.dart';
import 'package:catatan_keuangan/myutangpiutanglist.dart';
import 'package:catatan_keuangan/myutangreport.dart';
import 'package:catatan_keuangan/totalpiutang.dart';
import 'package:catatan_keuangan/totalutang.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io' as io;
import 'package:path/path.dart';
import 'dart:async';
import 'package:catatan_keuangan/mytrans.dart';
import 'package:catatan_keuangan/mykatagori.dart';

class TDBHelper {
  static Database _db;
  var now = DateTime.now();
  // static Future<bool> initialize() async {
  //   if (_db == null){
  //     _db = await SetDB();
  //   }
  // }
  static final TDBHelper _instance = new TDBHelper.internal();
  TDBHelper.internal();

  factory TDBHelper() => _instance;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDB();

    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "CatatanKeuanganDB");
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE mykatagori(id INTEGER PRIMARY KEY, nama TEXT, kasNama TEXT, st TEXT,jenis TEXT)");
    await db.execute(
        "CREATE TABLE mytrans(id INTEGER PRIMARY KEY, sumber TEXT, katagori TEXT, kas TEXT, kas1 TEXT, tipekas TEXT,person TEXT, rek TEXT, jenis TEXT,tipe TEXT,jumlah DOUBLE,ket TEXT,status TEXT,createDate TEXT, updateDate TEXT, birthDate TEXT,sortDate TEXT, notransaksi TEXT, status2 TEXT, notrans TEXT, urutanbayar INTEGER, status3 TEXT, status4 TEXT, bayar DOUBLE, sisa DOUBLE, kas_id INTEGER,person_id INTEGER,kategori_id INTEGER, FOREIGN KEY(katagori) REFERENCES mykatagori(nama) ON UPDATE CASCADE )");
    await db.execute(
        "CREATE TABLE myrutin(id INTEGER PRIMARY KEY, sumber TEXT, katagori TEXT, rek TEXT, jenis TEXT,tipe TEXT,jumlah DOUBLE,ket TEXT,status TEXT,createDate TEXT, updateDate TEXT, birthDate TEXT,sortDate TEXT, notransaksi TEXT, status2 TEXT, notrans TEXT, urutanbayar INTEGER, status3 TEXT, status4 TEXT, bayar DOUBLE, sisa DOUBLE, FOREIGN KEY(katagori) REFERENCES mykatagori(nama) ON UPDATE CASCADE )");
    await db.execute(
        "CREATE TABLE myutangpiutang(id INTEGER PRIMARY KEY, sumber TEXT, katagori TEXT, rek TEXT, jenis TEXT,tipe TEXT,jumlah DOUBLE,ket TEXT,status TEXT,createDate TEXT, updateDate TEXT, birthDate TEXT,sortDate TEXT,idtransaksi INTEGER, kas_id INTEGER,person_id INTEGER )");
    await db.execute(
        "CREATE TABLE mykas(id INTEGER PRIMARY KEY, kas TEXT, tipe TEXT)");
    await db.execute(
        "CREATE TABLE myperson(id INTEGER PRIMARY KEY,kode TEXT, namaKas TEXT,person TEXT, alamat TEXT,noTelp TEXT,jenisPerson TEXT)");

    await db.insert("mykatagori", {
      "id": 1,
      "nama": "Belanja",
      "jenis": "pengeluaran",
    });
    await db.insert("mykatagori", {
      "id": 2,
      "nama": "Makan",
      "jenis": "pengeluaran",
    });
    await db.insert("mykatagori", {
      "id": 3,
      "nama": "Bayar Utang",
      "jenis": "pengeluaran",
      "st": "y",
    });
    await db.insert("mykatagori", {
      "id": 4,
      "nama": "Gaji",
      "jenis": "penerimaan",
    });
    await db.insert("mykatagori", {
      "id": 5,
      "nama": "Usaha",
      "jenis": "penerimaan",
    });
    await db.insert("mykatagori", {
      "id": 6,
      "nama": "Bayar Piutang",
      "jenis": "penerimaan",
      "st": "y",
    });
    await db.insert("mykas", {
      "id": 1,
      "kas": "Dompet",
      "tipe": "",
    });
    print("db Created");
  }

  Future<int> saveTrans(Mytrans mytrans) async {
    var dbClient = await db;
    int res = await dbClient.insert("mytrans", mytrans.toMap());

    print("data inserted");
    return res;
  }

  Future<int> saveRutin(Myrutin myrutin) async {
    var dbClient = await db;
    int res = await dbClient.insert("myrutin", myrutin.toMap());

    print("data inserted");
    return res;
  }

  Future<int> saveTrans3(Mytransutangbelumlunas mytransutangbelumlunas) async {
    var dbClient = await db;
    int res = await dbClient.insert("mytrans", mytransutangbelumlunas.toMap());

    print("data inserted");
    return res;
  }

  Future<int> saveTransUtangBelumLunas(Mytrans mytrans) async {
    var dbClient = await db;
    int res = await dbClient.insert("mytrans", mytrans.toMap());

    print("data inserted");
    return res;
  }

  Future<int> saveTransUtangBelumLunas2(
      Mytransutangbelumlunas mytransutangbelumlunas) async {
    var dbClient = await db;
    int res = await dbClient.insert("mytrans", mytransutangbelumlunas.toMap());

    print("data inserted");
    return res;
  }

  Future<List<Mytrans>> getTrans() async {
    var dbClient = await db;

    var date3 =
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()).toString();

    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM mytrans WHERE createDate='$date3' AND status!='C' ORDER BY updateDate DESC");
    List<Mytrans> noteData = new List();
    for (int i = 0; i < list.length; i++) {
      var note = new Mytrans(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
        // list[i]['total'],
      );
      note.setTransId(list[i]['id']);
      noteData.add(note);
    }
    return noteData;
  }

  Future<List<Myrutin>> getRutin() async {
    var dbClient = await db;

    var date3 =
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()).toString();

    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM myrutin WHERE createDate='$date3' AND status!='C' ORDER BY updateDate DESC");
    List<Myrutin> rutinData = new List();
    for (int i = 0; i < list.length; i++) {
      var rutin = new Myrutin(
        list[i]['sumber'],
        list[i]['katagori'],
        // list[i]['kas'],
        // list[i]['kas1'],
        // list[i]['tipekas'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
        // list[i]['total'],
      );
      rutin.setRutinId(list[i]['id']);
      rutinData.add(rutin);
    }
    return rutinData;
  }

  Future<List<Mytransjumlah>> getTransJumlah() async {
    var dbClient = await db;

    var date3 =
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()).toString();

    List<Map> list = await dbClient.rawQuery(
        "SELECT *,(select sum(jumlah) from mytrans where jenis='penerimaan' and status2!='Bayar Piutang' and createDate='$date3') total,(select sum(jumlah) from mytrans where jenis='pengeluaran' and status2!='Bayar Utang' and createDate='$date3') total1,(select sum(jumlah) from mytrans where tipe='utang' and createDate='$date3') total2, (select sum(jumlah) from mytrans where tipe='piutang' and createDate='$date3') total3,(select sum(jumlah) from mytrans where jenis='penerimaan' and status2!='Bayar Piutang' and rek='bank' and createDate='$date3') total4,(select sum(jumlah) from mytrans where jenis='pengeluaran' and status2!='Bayar Utang' and rek='bank' and createDate='$date3') total5 FROM mytrans WHERE createDate='$date3' AND status!='C' GROUP BY createDate ORDER BY updateDate DESC");
    List<Mytransjumlah> noteData = new List();
    for (int i = 0; i < list.length; i++) {
      var note = new Mytransjumlah(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['total'],
        list[i]['total1'],
        list[i]['total2'],
        list[i]['total3'],
        list[i]['total4'],
        list[i]['total5'],
      );
      note.setTransId(list[i]['id']);
      noteData.add(note);
    }
    return noteData;
  }

  Future<List<Mytransjumlahgroupharian>> getTransJumlahgroupharian(
      $date) async {
    var dbClient = await db;

    var date3 = $date;
    //     DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()).toString();

    List<Map> list = await dbClient.rawQuery(
        "SELECT *,(select sum(jumlah) from mytrans where jenis='penerimaan' and rek='dompet' and createDate='$date3') total,(select sum(jumlah) from mytrans where jenis='pengeluaran' and status!='C' and rek='dompet' and createDate='$date3') total1,(select sum(jumlah) from mytrans where tipe='utang' and createDate='$date3') total2, (select sum(jumlah) from mytrans where tipe='piutang' and createDate='$date3') total3,(select sum(jumlah) from mytrans where jenis='penerimaan' and rek='bank' and createDate='$date3') total4,(select sum(jumlah) from mytrans where jenis='pengeluaran' and rek='bank' and createDate='$date3') total5 FROM mytrans WHERE createDate='$date3' AND status!='C' GROUP BY createDate ORDER BY updateDate DESC");
    List<Mytransjumlahgroupharian> harianData = new List();
    for (int i = 0; i < list.length; i++) {
      var harian = new Mytransjumlahgroupharian(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['total'],
        list[i]['total1'],
        list[i]['total2'],
        list[i]['total3'],
        list[i]['total4'],
        list[i]['total5'],
      );
      harian.setTransId(list[i]['id']);
      harianData.add(harian);
    }
    return harianData;
  }

  Future<List<Mytransjumlahgroup>> getTransJumlahgroup() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        "SELECT *,(select sum(jumlah) from mytrans where jenis='penerimaan' and rek='dompet' ) total,(select sum(jumlah) from mytrans where jenis='pengeluaran' and status2!='Bayar Utang' and rek='dompet' ) total1,(select sum(jumlah) from mytrans where tipe='utang' ) total2, (select sum(jumlah) from mytrans where tipe='piutang' ) total3,(select sum(jumlah) from mytrans where jenis='penerimaan'  and rek='bank' ) total4,(select sum(jumlah) from mytrans where jenis='pengeluaran' and rek='bank' ) total5 FROM mytrans GROUP BY status4 ORDER BY updateDate DESC");
    List<Mytransjumlahgroup> noteData = new List();
    for (int i = 0; i < list.length; i++) {
      var note = new Mytransjumlahgroup(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['total'],
        list[i]['total1'],
        list[i]['total2'],
        list[i]['total3'],
        list[i]['total4'],
        list[i]['total5'],
      );
      note.setTransId(list[i]['id']);
      noteData.add(note);
    }
    return noteData;
  }

  Future<List<Mytransgroup>> getTransGroup() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        "SELECT *,(SELECT SUM(jumlah) from mytrans where jenis='penerimaan') total,(SELECT SUM(jumlah) from mytrans where jenis='pengeluaran') total1 FROM mytrans GROUP BY createDate ORDER BY updateDate DESC");
    List<Mytransgroup> groupData = new List();
    for (int i = 0; i < list.length; i++) {
      var grup = new Mytransgroup(
        list[i]['updateDate'],
        list[i]['total'],
        list[i]['total1'],
      );
      // note.setTransId(list[i]['id']);
      groupData.add(grup);
    }
    return groupData;
  }

  Future<List<Mytransgroupdetail>> getTransGroupDetail(date) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM mytrans WHERE createDate='$date' AND status!='C' OR status!='D' ORDER BY updateDate DESC");
    List<Mytransgroupdetail> groupdetailData = new List();
    for (int i = 0; i < list.length; i++) {
      var groupdetail = new Mytransgroupdetail(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
      );
      groupdetail.setTransId(list[i]['id']);
      groupdetailData.add(groupdetail);
    }
    return groupdetailData;
  }

  Future<List<Mytransgroupdetail>> getTransGroupDetail2(date) async {
    var dbClient = await db;
    print(date);

    // var date3 = DateFormat(DateFormat.YEAR_MONTH_DAY).format(date).toString();

    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM mytrans WHERE createDate='$date' AND status!='C' OR status!='D' ORDER BY updateDate DESC");
    List<Mytransgroupdetail> groupdetailData2 = new List();
    for (int i = 0; i < list.length; i++) {
      var groupdetail2 = new Mytransgroupdetail(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
      );
      groupdetail2.setTransId(list[i]['id']);
      groupdetailData2.add(groupdetail2);
    }
    return groupdetailData2;
  }

  Future<List<Mytrans>> getTrans2(nama) async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM mytrans where katagori=$nama   ORDER BY createDate DESC');
    List<Mytrans> noteData = new List();
    for (int i = 0; i < list.length; i++) {
      var note = new Mytrans(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
      );
      note.setTransId(list[i]['id']);
      noteData.add(note);
    }
    return noteData;
  }

  Future<List<Mytransutang>> getTransUtangBelumLunas() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM mytrans where tipe="utang" and status="B" ORDER BY sortDate DESC');
    List<Mytransutang> utangData = new List();
    for (int i = 0; i < list.length; i++) {
      var utang = new Mytransutang(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
      );
      utang.setTransId(list[i]['id']);
      utangData.add(utang);
    }
    return utangData;
  }

  Future<List<Mytranspiutang>> getTransPiutangBelumLunas() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM mytrans where tipe="piutang" and status="B" ORDER BY sortDate DESC');
    List<Mytranspiutang> piutangData = new List();
    for (int i = 0; i < list.length; i++) {
      var piutang = new Mytranspiutang(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
      );
      piutang.setTransId(list[i]['id']);
      piutangData.add(piutang);
    }
    return piutangData;
  }

  Future<List<Mytransutangbelumlunas>> getTransUtangBelumLunasreport(
      trans) async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM mytrans where notransaksi=$trans and status="C"  ORDER BY sortDate DESC');
    List<Mytransutangbelumlunas> utangreportData = new List();
    for (int i = 0; i < list.length; i++) {
      var utangreport = new Mytransutangbelumlunas(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
      );
      utangreport.setTransId(list[i]['id']);
      utangreportData.add(utangreport);
    }
    return utangreportData;
  }

  Future<List<Myutangjumlah2>> getUtangJumlah2() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT *,(select sum(jumlah) from mytrans where status="C" group by notrans ) total FROM mytrans where tipe="utang" and status="B" GROUP BY notransaksi  ');
    List<Myutangjumlah2> utangjumlahData = new List();
    for (int i = 0; i < list.length; i++) {
      var utangjumlah = new Myutangjumlah2(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['total'],
      );
      utangjumlah.setTransId(list[i]['id']);
      utangjumlahData.add(utangjumlah);
    }
    return utangjumlahData;
  }

  Future<List<Myutangjumlah>> getUtangJumlah(trans) async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT *,(select sum(jumlah) from mytrans where tipe="utang" and status="B" and notransaksi=$trans) total,(select sum(jumlah) from mytrans where status="C" and notransaksi=$trans) total1 FROM mytrans where notransaksi=$trans GROUP BY notransaksi ');
    List<Myutangjumlah> utangjumlahData = new List();
    for (int i = 0; i < list.length; i++) {
      var utangjumlah = new Myutangjumlah(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['total'],
        list[i]['total1'],
      );
      utangjumlah.setTransId(list[i]['id']);
      utangjumlahData.add(utangjumlah);
    }
    return utangjumlahData;
  }

  Future<List<Mypiutangjumlah>> getPiutangJumlah(trans) async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT *,(select sum(jumlah) from mytrans where tipe="piutang" and status="B" and notransaksi=$trans) total,(select sum(jumlah) from mytrans where status="C" and notransaksi=$trans) total1 FROM mytrans where notransaksi=$trans GROUP BY notransaksi ');
    List<Mypiutangjumlah> piutangjumlahData = new List();
    for (int i = 0; i < list.length; i++) {
      var piutangjumlah = new Mypiutangjumlah(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['total'],
        list[i]['total1'],
      );
      piutangjumlah.setTransId(list[i]['id']);
      piutangjumlahData.add(piutangjumlah);
    }
    return piutangjumlahData;
  }

  Future<List<Totalutang>> getUtangTotal() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT *,(select sum(jumlah) from mytrans where tipe="utang" and status="B") total,(select sum(jumlah) from mytrans where status2="Bayar Utang" and status3="Belum Lunas" ) total1 FROM mytrans GROUP BY status4 ');
    List<Totalutang> utangtotalData = new List();
    for (int i = 0; i < list.length; i++) {
      var utangtotal = new Totalutang(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
        list[i]['total'],
        list[i]['total1'],
      );
      utangtotal.setTransId(list[i]['id']);
      utangtotalData.add(utangtotal);
    }
    return utangtotalData;
  }

  Future<List<Totalpiutang>> getPiutangTotal() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT *,(select sum(jumlah) from mytrans where tipe="piutang" and status="B") total,(select sum(jumlah) from mytrans where status2="Bayar Piutang" and status3="Belum Lunas" ) total1 FROM mytrans GROUP BY status4 ');
    List<Totalpiutang> piutangtotalData = new List();
    for (int i = 0; i < list.length; i++) {
      var piutangtotal = new Totalpiutang(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
        list[i]['total'],
        list[i]['total1'],
      );
      piutangtotal.setTransId(list[i]['id']);
      piutangtotalData.add(piutangtotal);
    }
    return piutangtotalData;
  }

  Future<List<Myutangreport>> getUtangReport() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT *,(select sum(jumlah) from mytrans where tipe="utang"  ) total,(select sum(jumlah) from mytrans where status="C" ) total1 FROM mytrans where status="Lunas" GROUP BY notransaksi ');
    List<Myutangreport> utangjumlahData = new List();
    for (int i = 0; i < list.length; i++) {
      var utangjumlah = new Myutangreport(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
        list[i]['total'],
        list[i]['total1'],
      );
      utangjumlah.setTransId(list[i]['id']);
      utangjumlahData.add(utangjumlah);
    }
    return utangjumlahData;
  }

  Future<List<Mytranspiutangbelumlunas>> getTransPiutangBelumLunasreport(
      trans) async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM mytrans where notransaksi=$trans and status="C"  ORDER BY sortDate DESC');
    List<Mytranspiutangbelumlunas> piutangreportData = new List();
    for (int i = 0; i < list.length; i++) {
      var piutangreport = new Mytranspiutangbelumlunas(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['kas'],
        list[i]['kas1'],
        list[i]['tipekas'],
        list[i]['person'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['notransaksi'],
        list[i]['status2'],
        list[i]['notrans'],
        list[i]['urutanbayar'],
        list[i]['status3'],
        list[i]['status4'],
      );
      piutangreport.setTransId(list[i]['id']);
      piutangreportData.add(piutangreport);
    }
    return piutangreportData;
  }

  Future<List<Mytransjmpn>> getJumlahPenerimaanHarian(nama) async {
    var now = DateTime.now();
    var dbClient = await db;
    var date3 = DateFormat(DateFormat.YEAR_MONTH_DAY).format(now).toString();

    List<Map> list = await dbClient.rawQuery(
        'SELECT SUM(jumlah) as Total FROM mytrans where createDate="$date3" and jenis="$nama" GROUP BY "penerimaan" ');

    List<Mytransjmpn> totalData = new List();
    for (int i = 0; i < list.length; i++) {
      var total = new Mytransjmpn(
        list[i]['total'],
      );
      // total.setTransId(list[i]['id']);
      totalData.add(total);
    }
    return totalData;
  }

  // Mytransjmpn mytransjmpn = new Mytransjmpn.();

  Future getJumlah() async {
    var dbClient = await db;

    var result = await dbClient.rawQuery('SELECT SUM(jumlah) FROM mytrans ');
    int value = result[0]["jumlah"];
    return value;
  }

  Future<List> calculateTotal() async {
    var dbClient = await db;

    var result =
        await dbClient.rawQuery('SELECT SUM(jumlah) as total FROM mytrans ');
    return result.toList();
  }

  Future<bool> updateTrans(Mytrans mytrans) async {
    var dbClient = await db;
    int res = await dbClient.update("mytrans", mytrans.toMap(),
        where: "id=?", whereArgs: <int>[mytrans.id]);
    return res > 0 ? true : false;
  }

  Future<bool> updateRutin(Myrutin myrutin) async {
    var dbClient = await db;
    int res = await dbClient.update("myrutin", myrutin.toMap(),
        where: "id=?", whereArgs: <int>[myrutin.id]);
    return res > 0 ? true : false;
  }

  Future<bool> updateTransSemua(Mytransgroupdetail mytransgroupdetail2) async {
    var dbClient = await db;
    int res = await dbClient.update("mytrans", mytransgroupdetail2.toMap(),
        where: "notransaksi=?",
        whereArgs: <int>[int.parse(mytransgroupdetail2.notransaksi)]);
    return res > 0 ? true : false;
  }

  Future<bool> updateUrutan(Mytransurutan mytransutang, id) async {
    var dbClient = await db;
    int res = await dbClient.update("mytrans", mytransutang.toMap(),
        where: "id=?", whereArgs: <int>[id]);
    return res > 0 ? true : false;
  }

  Future<bool> updateTransDetail(Mytransgroupdetail mytransgroupdetail) async {
    var dbClient = await db;
    int res = await dbClient.update("mytrans", mytransgroupdetail.toMap(),
        where: "notransaksi=?",
        whereArgs: <int>[int.parse(mytransgroupdetail.notransaksi)]);
    return res > 0 ? true : false;
  }

  Future<bool> updateTrans2(Mytrans2 mytrans2, nama2, nama) async {
    var dbClient = await db;
    int res = await dbClient.update("mytrans", mytrans2.toMap(),
        where: "katagori=?", whereArgs: [nama]);
    return res > 0 ? true : false;
  }

  Future<bool> updateTransStatus(Mytransstatus mytransstatus, nama2) async {
    var dbClient = await db;
    int res = await dbClient.update(
      "mytrans",
      mytransstatus.toMap(),
      where: "notransaksi=$nama2 AND status2='Bayar Utang' ",
    );
    return res > 0 ? true : false;
  }

  Future<bool> updateTransStatus2(Mytransstatus mytransstatus, nama2) async {
    var dbClient = await db;
    int res = await dbClient.update(
      "mytrans",
      mytransstatus.toMap(),
      where: "notransaksi=$nama2 AND status2='Bayar Utang' ",
    );
    return res > 0 ? true : false;
  }

  Future<bool> updateTransStatus5(Mytransstatus mytransstatus2, nama2) async {
    var dbClient = await db;
    int res = await dbClient.update(
      "mytrans",
      mytransstatus2.toMap(),
      where: "notransaksi=$nama2 AND status2='Bayar Utang' ",
    );
    return res > 0 ? true : false;
  }

  Future<bool> updateTransStatus3(Mytransstatus mytransstatus, nama2) async {
    var dbClient = await db;
    int res = await dbClient.update(
      "mytrans",
      mytransstatus.toMap(),
      where: "notransaksi=$nama2 AND status2='Bayar Piutang' ",
    );
    return res > 0 ? true : false;
  }

  Future<bool> updateTransStatus4(Mytransstatus mytransstatus1, nama2) async {
    var dbClient = await db;
    int res = await dbClient.update(
      "mytrans",
      mytransstatus1.toMap(),
      where: "notransaksi=$nama2 AND status2='Bayar Piutang' ",
    );
    return res > 0 ? true : false;
  }

  Future<bool> updateTransStatuslunas(
      Mytransstatus3 mytransstatus3, nama2) async {
    var dbClient = await db;
    int res = await dbClient.update(
      "mytrans",
      mytransstatus3.toMap(),
      where: "notransaksi=$nama2 AND status='B' ",
    );
    return res > 0 ? true : false;
  }

  Future<bool> updateDetailUtang(Mytransdetail mytransdetail, nama2) async {
    var dbClient = await db;
    int res = await dbClient.update(
      "mytrans",
      mytransdetail.toMap(),
      where: "notrans='$nama2' ",
    );
    return res > 0 ? true : false;
  }

  Future<bool> updateDetailUtangBelumLunas(
      Mytransutangbelumlunas mytransutangbelumlunas, nama2) async {
    var dbClient = await db;
    int res = await dbClient.update(
      "mytrans",
      mytransutangbelumlunas.toMap(),
      where: "notrans=$nama2 AND status='C' ",
    );
    return res > 0 ? true : false;
  }

  Future<int> deleteTrans(Mytrans mytrans) async {
    var dbClient = await db;
    int res = await dbClient.rawDelete(
        'DELETE FROM mytrans WHERE notransaksi=?', [mytrans.notransaksi]);
    return res;
  }

  Future<int> deleteRutin(Myrutin myrutin) async {
    var dbClient = await db;
    int res = await dbClient.rawDelete(
        'DELETE FROM myrutin WHERE notransaksi=?', [myrutin.notransaksi]);
    return res;
  }

  Future<int> deleteTransSemua(Mytransgroupdetail mytransgroupdetail2) async {
    var dbClient = await db;
    int res = await dbClient.rawDelete(
        'DELETE FROM mytrans WHERE notransaksi=?',
        [mytransgroupdetail2.notransaksi]);
    return res;
  }

  Future<int> deleteTransDetail(Mytransgroupdetail mytransgroupdetail) async {
    var dbClient = await db;
    int res = await dbClient.rawDelete(
        'DELETE FROM mytrans WHERE notransaksi=?',
        [mytransgroupdetail.notransaksi]);
    return res;
  }

  // Utang Piutang

  // Future<int> saveUtangPiutang(Myutangpiutang myutangpiutang) async {
  //   var dbClient = await db;
  //   int res = await dbClient.insert("myutangpiutang", myutangpiutang.toMap());

  //   print("data inserted");
  //   return res;
  // }

  // Future<List<Myutangpiutang>> getUtang() async {
  //   var dbClient = await db;

  //   List<Map> list = await dbClient
  //       .rawQuery("SELECT * FROM myutangpiutang ORDER BY updateDate DESC");
  //   List<Myutangpiutang> utangData = new List();
  //   for (int i = 0; i < list.length; i++) {
  //     var utang = new Myutangpiutang(
  //       list[i]['sumber'],
  //       list[i]['katagori'],
  //       list[i]['rek'],
  //       list[i]['jenis'],
  //       list[i]['tipe'],
  //       list[i]['jumlah'],
  //       list[i]['ket'],
  //       list[i]['status'],
  //       list[i]['createDate'],
  //       list[i]['updateDate'],
  //       list[i]['birthDate'],
  //       list[i]['sortDate'],
  //       list[i]['idtransaksi'],
  //     );
  //     utang.setUtangPiutangId(list[i]['id']);
  //     utangData.add(utang);
  //   }
  //   return utangData;
  // }

  Future<List<Myutangpiutanglist>> getUtangDetail(trans) async {
    var dbClient = await db;
    // print(date);

    // var date3 = DateFormat(DateFormat.YEAR_MONTH_DAY).format(date).toString();

    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM myutangpiutang WHERE idtransaksi=$trans and status='C'  ORDER BY updateDate DESC");
    List<Myutangpiutanglist> utangData2 = new List();
    for (int i = 0; i < list.length; i++) {
      var utang = new Myutangpiutanglist(
        list[i]['sumber'],
        list[i]['katagori'],
        list[i]['rek'],
        list[i]['jenis'],
        list[i]['tipe'],
        list[i]['jumlah'],
        list[i]['ket'],
        list[i]['status'],
        list[i]['createDate'],
        list[i]['updateDate'],
        list[i]['birthDate'],
        list[i]['sortDate'],
        list[i]['idtransaksi'],
      );
      utang.setUtangPiutangId(list[i]['id']);
      utangData2.add(utang);
    }
    return utangData2;
  }

  // Future<List<Myutangpiutang>> getPiutang() async {
  //   var dbClient = await db;

  //   List<Map> list = await dbClient.rawQuery(
  //       "SELECT * FROM myutangpiutang WHERE tipe='piutang' ORDER BY updateDate DESC");
  //   List<Myutangpiutang> utangData = new List();
  //   for (int i = 0; i < list.length; i++) {
  //     var utang = new Myutangpiutang(
  //       list[i]['sumber'],
  //       list[i]['katagori'],
  //       list[i]['rek'],
  //       list[i]['jenis'],
  //       list[i]['tipe'],
  //       list[i]['jumlah'],
  //       list[i]['ket'],
  //       list[i]['status'],
  //       list[i]['createDate'],
  //       list[i]['updateDate'],
  //       list[i]['birthDate'],
  //       list[i]['sortDate'],
  //       list[i]['idtransaksi'],
  //     );
  //     utang.setUtangPiutangId(list[i]['id']);
  //     utangData.add(utang);
  //   }
  //   return utangData;
  // }

  // Future<bool> updateUtangPiutang(Myutangpiutang myutangpiutang) async {
  //   var dbClient = await db;
  //   int res = await dbClient.update("myutangpiutang", myutangpiutang.toMap(),
  //       where: "id=?", whereArgs: <int>[myutangpiutang.id]);
  //   return res > 0 ? true : false;
  // }

  Future<bool> updateUtangReport(Myutangpiutanglist myutangpiutanglist) async {
    var dbClient = await db;
    int res = await dbClient.update(
        "myutangpiutang", myutangpiutanglist.toMap(),
        where: "id=?", whereArgs: <int>[myutangpiutanglist.id]);
    return res > 0 ? true : false;
  }

  Future<int> deleteUtangPiutang(i) async {
    var dbClient = await db;
    int res =
        await dbClient.rawDelete('DELETE FROM myutangpiutang WHERE id=?', [i]);
    return res;
  }

  //Katagori
  Future<int> saveKatagori(Mykatagori mykatagori) async {
    var dbClient = await db;
    int res = await dbClient.insert("mykatagori", mykatagori.toMap());

    print("data inserted");
    return res;
  }

  Future<List<Mykatagori>> getKatagori() async {
    var dbClient = await db;

    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM mykatagori ORDER BY nama ASC');
    List<Mykatagori> katagoriData = new List();
    for (int i = 0; i < list.length; i++) {
      var katagori = new Mykatagori(
        list[i]['nama'],
        list[i]['jenis'],
        list[i]['st'],
      );
      katagori.setKatagoriId(list[i]['id']);
      katagoriData.add(katagori);
    }
    return katagoriData;
  }

  Future<List<Mykatagori>> getKatagoriPenerimaan() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM mykatagori where jenis="penerimaan" ORDER BY id ASC');
    List<Mykatagori> katpenerimaanData = new List();
    for (int i = 0; i < list.length; i++) {
      var katpenerimaan = new Mykatagori(
        list[i]['nama'],
        list[i]['jenis'],
        list[i]['st'],
      );
      katpenerimaan.setKatagoriId(list[i]['id']);
      katpenerimaanData.add(katpenerimaan);
    }
    return katpenerimaanData;
  }

  Future<List<Mykatagori>> getKatagoriPengeluaran() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM mykatagori where jenis="pengeluaran" ORDER BY id ASC');
    List<Mykatagori> katpengeluaranData = new List();
    for (int i = 0; i < list.length; i++) {
      var katpengeluaran = new Mykatagori(
        list[i]['nama'],
        list[i]['jenis'],
        list[i]['st'],
      );
      katpengeluaran.setKatagoriId(list[i]['id']);
      katpengeluaranData.add(katpengeluaran);
    }
    return katpengeluaranData;
  }

  Future<bool> updateKatagori(Mykatagori mykatagori) async {
    var dbClient = await db;
    int res = await dbClient.update("mykatagori", mykatagori.toMap(),
        where: "id=?", whereArgs: <int>[mykatagori.id]);
    return res > 0 ? true : false;
  }

  Future<int> deleteKatagori(Mykatagori mykatagori) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM mykatagori WHERE id=?', [mykatagori.id]);
    return res;
  }

  Future<Mykatagori> getById(i) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery('SELECT * FROM mykatagori WHERE id=?', [i]);
    if (result.length > 0) {
      return new Mykatagori.map(result.first);
    } else
      return null;
    // return new Mykatagori.map(res.first, _jenis, _sortdate);
  }

  Future<Mykatagori> getByNama(nama) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery('SELECT * FROM mykatagori WHERE nama=?', [nama]);
    if (result.length > 0) {
      return new Mykatagori.map(result.first);
    } else
      return null;
    // return new Mykatagori.map(res.first, _jenis, _sortdate);
  }

  Future<Mykatagori> getByNamaPenerimaan(nama) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM mykatagori WHERE nama='$nama' and jenis='penerimaan'");
    if (result.length > 0) {
      return new Mykatagori.map(result.first);
    } else
      return null;
    // return new Mykatagori.map(res.first, _jenis, _sortdate);
  }

  Future<Mykatagori> getByNamaPengeluaran(nama) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM mykatagori WHERE nama='$nama' and jenis='pengeluaran'");
    if (result.length > 0) {
      return new Mykatagori.map(result.first);
    } else
      return null;
    // return new Mykatagori.map(res.first, _jenis, _sortdate);
  }

  // getTransPiutangBelumLunasreport(int notransaksi) {}

  // KAS

  Future<List<Mykas>> getKas() async {
    var dbClient = await db;

    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM mykas ORDER BY id ASC');
    List<Mykas> kasData = new List();
    for (int i = 0; i < list.length; i++) {
      var kas = new Mykas(
        list[i]['kas'],
        list[i]['tipe'],
      );
      kas.setkasId(list[i]['id']);
      kasData.add(kas);
    }
    return kasData;
  }

  Future<Mykas> getByNamaKas(nama) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery('SELECT * FROM mykas WHERE kas=?', [nama]);
    if (result.length > 0) {
      return new Mykas.map(result.first);
    } else
      return null;
    // return new Mykatagori.map(res.first, _jenis, _sortdate);
  }

  Future<int> saveKas(Mykas mykas) async {
    var dbClient = await db;
    int res = await dbClient.insert("mykas", mykas.toMap());

    print("data inserted");
    return res;
  }

  Future<bool> updateKas(Mykas mykas) async {
    var dbClient = await db;
    int res = await dbClient.update("mykas", mykas.toMap(),
        where: "id=?", whereArgs: <int>[mykas.id]);
    return res > 0 ? true : false;
  }

  Future<bool> updateTransKas(Mytrans3 mytrans3, nama2, nama) async {
    var dbClient = await db;
    int res = await dbClient
        .update("mytrans", mytrans3.toMap(), where: "kas=?", whereArgs: [nama]);
    return res > 0 ? true : false;
  }

  Future<bool> updateTransKas2(Mytrans4 mytrans4, nama2, nama) async {
    var dbClient = await db;
    int res = await dbClient.update("mytrans", mytrans4.toMap(),
        where: "kas2=?", whereArgs: [nama]);
    return res > 0 ? true : false;
  }

  Future<bool> updateTransKas3(Mytrans6 mytrans6, nama2, nama) async {
    var dbClient = await db;
    int res = await dbClient.update("myperson", mytrans6.toMap(),
        where: "namaKas=?", whereArgs: [nama]);
    return res > 0 ? true : false;
  }

  Future<int> deleteKas(Mykas mykas) async {
    var dbClient = await db;
    int res =
        await dbClient.rawDelete('DELETE FROM mykas WHERE id=?', [mykas.id]);
    return res;
  }

  // PERSON

  Future<List<Myperson>> getPerson() async {
    var dbClient = await db;

    List<Map> list =
        await dbClient.rawQuery('SELECT * FROM myperson ORDER BY id ASC');
    List<Myperson> personData = new List();
    for (int i = 0; i < list.length; i++) {
      var person = new Myperson(
        list[i]['kode'],
        list[i]['namKas'],
        list[i]['person'],
        list[i]['alamat'],
        list[i]['noTelp'],
        list[i]['jenisPerson'],
      );
      person.setpersonId(list[i]['id']);
      personData.add(person);
    }
    return personData;
  }

  Future<List<Myperson>> getPersonPenerimaan() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM myperson where jenisPerson="penerimaan" ORDER BY id ASC');
    List<Myperson> katpenerimaanData = new List();
    for (int i = 0; i < list.length; i++) {
      var katpenerimaan = new Myperson(
        list[i]['kode'],
        list[i]['namaKas'],
        list[i]['person'],
        list[i]['alamat'],
        list[i]['noTelp'],
        list[i]['jenisPerson'],
      );
      katpenerimaan.setpersonId(list[i]['id']);
      katpenerimaanData.add(katpenerimaan);
    }
    return katpenerimaanData;
  }

  Future<List<Myperson>> getPersonPengeluaran() async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM myperson where jenisPerson="pengeluaran" ORDER BY id ASC');
    List<Myperson> katpenerimaanData = new List();
    for (int i = 0; i < list.length; i++) {
      var katpenerimaan = new Myperson(
        list[i]['kode'],
        list[i]['namaKas'],
        list[i]['person'],
        list[i]['alamat'],
        list[i]['noTelp'],
        list[i]['jenisPerson'],
      );
      katpenerimaan.setpersonId(list[i]['id']);
      katpenerimaanData.add(katpenerimaan);
    }
    return katpenerimaanData;
  }

  Future<List<Myperson>> getPersonPengeluaranTr(nama) async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM myperson WHERE namaKas='$nama' and jenisPerson='pengeluaran'");
    List<Myperson> katpengeluaranData = new List();
    for (int i = 0; i < list.length; i++) {
      var katpengeluaran = new Myperson(
        list[i]['kode'],
        list[i]['namaKas'],
        list[i]['person'],
        list[i]['alamat'],
        list[i]['noTelp'],
        list[i]['jenisPerson'],
      );
      katpengeluaran.setpersonId(list[i]['id']);
      katpengeluaranData.add(katpengeluaran);
    }
    return katpengeluaranData;
  }

  Future<List<Myperson>> getPersonPenerimaanTr(kas5) async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM myperson WHERE namaKas='$kas5' and jenisPerson='penerimaan'");
    List<Myperson> katpenerimaanData = new List();
    for (int i = 0; i < list.length; i++) {
      var katpenerimaan = new Myperson(
        list[i]['kode'],
        list[i]['namaKas'],
        list[i]['person'],
        list[i]['alamat'],
        list[i]['noTelp'],
        list[i]['jenisPerson'],
      );
      katpenerimaan.setpersonId(list[i]['id']);
      katpenerimaanData.add(katpenerimaan);
    }
    return katpenerimaanData;
  }

  Future<Myperson> getByNamaPersonPenerimaan(nama) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM myperson WHERE kode='$nama' and jenisPerson='penerimaan'");
    if (result.length > 0) {
      return new Myperson.map(result.first);
    } else
      return null;
    // return new Mykatagori.map(res.first, _jenis, _sortdate);
  }

  Future<Myperson> getByNamaPersonPengeluaran(nama) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM myperson WHERE kode='$nama' and jenisPerson='penerimaan'");
    if (result.length > 0) {
      return new Myperson.map(result.first);
    } else
      return null;
    // return new Mykatagori.map(res.first, _jenis, _sortdate);
  }

  Future<Myperson> getByNamaPerson(nama) async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery('SELECT * FROM myperson WHERE kode=?', [nama]);
    if (result.length > 0) {
      return new Myperson.map(result.first);
    } else
      return null;
    // return new Mykatagori.map(res.first, _jenis, _sortdate);
  }

  Future<int> savePerson(Myperson myperson) async {
    var dbClient = await db;
    int res = await dbClient.insert("myperson", myperson.toMap());

    print("data inserted");
    return res;
  }

  Future<bool> updatePerson(Myperson myperson) async {
    var dbClient = await db;
    int res = await dbClient.update("myperson", myperson.toMap(),
        where: "id=?", whereArgs: <int>[myperson.id]);
    return res > 0 ? true : false;
  }

  Future<bool> updateTransPerson(Mytrans5 mytrans5, nama2, nama) async {
    var dbClient = await db;
    int res = await dbClient.update("mytrans", mytrans5.toMap(),
        where: "person=?", whereArgs: [nama]);
    return res > 0 ? true : false;
  }

  Future<int> deletePerson(Myperson mykas) async {
    var dbClient = await db;
    int res =
        await dbClient.rawDelete('DELETE FROM myperson WHERE id=?', [mykas.id]);
    return res;
  }
}
