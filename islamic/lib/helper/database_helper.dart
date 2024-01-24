
import 'package:flutter/cupertino.dart';
import 'package:search_islam/data/model/audio_model.dart';
import 'package:search_islam/data/model/ojifa_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class DatabaseHelper {
  static const databaseName = 'ISLAM.db';
  static const databaseVersion = 1;

  //Table Name
  static const suraTable = 'SuraNameTbl';
  static const ayatTable = 'AyatTbl';
  static const audioTable = 'AudioTbl';
  static const paraTable = 'ParaNameTbl';
  static const quranWordTable = 'QuranWorkMeaningTbl';
  static const ojifaTable = 'OjifaTbl';
  static const dunaNameTable = 'DuaNameTbl';
  static const duyaDetailsTable = 'DuaDetailsTbl';
  static const hadisTable = 'HadisTbl';
  static const niyomTable = 'NiyomTbl';

  //Column Name
  static const columnSuraNo = 'SURANO';
  static const columnQarename = 'QARINAME';
  static const columnEnglishName = 'ENGLISHSURANAME';
  static const columnBanglaName = 'BANGLATRANSLATOR';
  static const columnArabi = 'ARABISURANAME';
  static const columnobotirno = 'OBOTIRNO';
  static const columnparaNo = 'PARA';
  static const columndate = 'DATEPRAYER';
  static const columntopicNo = 'TOPICNO';
  static const columnsubtopicNo = 'SUBTOPICNO';
  static const columndoyaID = 'ID';
  static const columnCategory = 'CATEGORY';
  static const columnduyaName = 'NAME';
  static const columnGlobalId = 'GLOBAL_ID';

  DatabaseHelper._privateConstrator();

  static final  DatabaseHelper instance = DatabaseHelper._privateConstrator();

  static late Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);

    var exists = await databaseExists(path);
    if (!exists) {
      debugPrint('Copy Database Start');

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets/database/", databaseName));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //write
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      debugPrint('Opening existing database');
    }

    return await openDatabase(path, version: databaseVersion);
  }

  ///CRUD
  ///==========================================================
  Future<List> getAllSubOjifaFromOjifaTable(int topicno) async {
    Database db = await instance.database;
    var result = await db.query(ojifaTable, where: '$columntopicNo = ? ', whereArgs: [topicno]);
    return result.toList();
  }

  Future<OjifaModel?> getAllOjifaFromOjifaTable(int topicno, int subtopicno) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> result =
        await db.query(ojifaTable, where: '$columntopicNo = ? AND $columnsubtopicNo = ? ', whereArgs: [topicno, subtopicno]);
    if (result.isNotEmpty) {
      return OjifaModel.fromMap(result.first);
    }
    return null;
  }
  Future<List> getDuyaNameFromTable() async {
    Database db = await instance.database;
    var result = await db.query(dunaNameTable,orderBy: 'GLOBAL_ID');
    return result.toList();
  }

  Future<List> getDuyaCategoryNameFromTable(int category) async {
    Database db = await instance.database;
    var result = await db.query(dunaNameTable, where: '$columnCategory = ? ', whereArgs: [category],orderBy: 'GLOBAL_ID');
    return result.toList();
  }

  Future<List> getDuyaDetailsFromTable(String id) async {
    Database db = await instance.database;
    var result = await db.query(duyaDetailsTable, where: '$columndoyaID = ? ', whereArgs: [id]);
    return result.toList();
  }

  Future<List> getAllSuraFromSuraNameTable() async {
    Database db = await instance.database;
    var result = await db.query(suraTable);
    return result.toList();
  }

  Future<List> getAllHadisFromHadisTable() async {
    Database db = await instance.database;
    var result = await db.query(hadisTable);
    return result.toList();
  }

  Future<List> getAllParaNameFromTable() async {
    Database db = await instance.database;
    var result = await db.query(paraTable);
    return result.toList();
  }
  Future<List> getAllAyatFromParaTable(int paraNo) async {
    Database db = await instance.database;
//    var result=await db.rawQuery('SELECT * FROM $ayatTable WHERE SURANO=$suraNo;');
    var result = await db.query(ayatTable, where: '$columnparaNo= ?', whereArgs: [paraNo]);
    return result.toList();
  }

  Future<List> getAllAyatFromAyatTable(int suraNo) async {
    Database db = await instance.database;
//    var result=await db.rawQuery('SELECT * FROM $ayatTable WHERE SURANO=$suraNo;');
    var result = await db.query(ayatTable, where: '$columnSuraNo= ?', whereArgs: [suraNo]);
    return result.toList();
  }

  Future<AudioModel> getAudioBySuraAndQareName(int surano, String qarename) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> qareNames =
    await db.query(audioTable, where: '$columnSuraNo = ? AND $columnQarename = ?', whereArgs: [surano, qarename]);
    if (qareNames.length > 0) {
      return AudioModel.fromMap(qareNames.first);
    }
    return AudioModel();
  }


}
