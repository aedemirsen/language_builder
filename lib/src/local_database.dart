import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'language_model.dart';

class DatabaseOps {
  static String defaultLang;

  static Database _database;

  DatabaseOps._();
  static final DatabaseOps db = DatabaseOps._();

  static const int _id = 1;

  Future<Database> get database async {
    if (_database != null) {
      var queryResult =
          await _database.rawQuery('SELECT * FROM Language WHERE id="1"');
      if (queryResult.isEmpty) {
        addLangRecord();
      }
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  addLangRecord() async {
    await _database.insert("Language", Language(_id, defaultLang).toMap());
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Settings.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db
          .execute("CREATE TABLE Language (id INTEGER PRIMARY KEY, lang TEXT)");
      //add default language record
      await db.insert("Language", Language(_id, defaultLang).toMap());
    });
  }

  //Read
  getLang() async {
    final db = await database;
    var res = await db.query("Language", where: "id = ?", whereArgs: [_id]);
    return res.isEmpty ? Null : Language.fromMap(res.first);
  }

  //Update
  updateLang(String langCode) async {
    Language _lang = Language(_id, langCode);
    var result = await _database.update(
      'Language',
      _lang.toMap(),
      where: "id = $_id",
    );
    // String _langTxt = _tr;
    // Language _langFuture = await getLang();
    // if (_langFuture.lang == 'tr') _langTxt = _en;
    // Language _lang = Language(1, _langTxt);
    // var sonuc = await _database.update(
    //   'Language',
    //   _lang.toMap(),
    //   where: "id = $_id",
    // );
    return result;
  }

  //Delete
  deleteLangRecord() async {
    await _database.delete("Language", where: "id = 1");
  }
}
