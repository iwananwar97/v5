import 'package:catatan_keuangan/mykatagori.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io' as io;
import 'package:path/path.dart';
import 'dart:async';

class KDBHelper {
  static final KDBHelper _instance = new KDBHelper.internal();
  KDBHelper.internal();

  factory KDBHelper() => _instance;

  static Database _db;

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
        "CREATE TABLE mykatagori(id INTEGER PRIMARY KEY, nama TEXT, jenis TEXT)");
    await db.execute('CREATE');
    print("db Created");
  }

  Future<int> saveKatagori(Mykatagori mykatagori) async {
    var dbClient = await db;
    int res = await dbClient.insert("mykatagori", mykatagori.toMap());

    print("data inserted");
    return res;
  }

  Future<List<Mykatagori>> getKatagori() async {
    var dbClient = await db;

    List<Map> list = await dbClient
        .rawQuery('SELECT * FROM mykatagori ORDER BY sortDate DESC');
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
        'SELECT * FROM mykatagori where jenis="penerimaan" ORDER BY sortDate DESC');
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
}
