import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:sqlite/notes_model.dart';

class DBHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "notes.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      create table notes(id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NOT NULL)
    ''');
  }

  Future<notesModel> insert(notesModel notes) async {
    var dbClint = await db;
    await dbClint!.insert("notes", notes.toMap());

    return notes;
  }

  Future<List<notesModel>> getNotesList() async {
    var dbClint = await db;
    final queryResult = await dbClint!.query("notes");
    return queryResult.map((e) => notesModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClint = await db;
    return await dbClint!.delete("notes", where: "id = ?", whereArgs: [id]);
  }

  Future<int> edit(notesModel notesModel) async {
    var dbClint = await db;
    return await dbClint!.update(
      "notes",
      notesModel.toMap(),
      where: "id = ?",
      whereArgs: [notesModel.id],
    );
  }
}
