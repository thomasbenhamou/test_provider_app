import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_provider_app/db/ChecklistModel.dart';
import 'package:test_provider_app/db/CheckModel.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Checkio.db");
    await deleteDatabase(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Checklist ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT"
              ")");
          await db.execute("CREATE TABLE Checks ("
              "id INTEGER PRIMARY KEY,"
              "category TEXT,"
              "nb INTEGER,"
              "state BOOLEAN NOT NULL CHECK (state IN (0,1)),"
              "checklistid INTEGER,"
              "FOREIGN KEY(checklistid) REFERENCES Checklist(id)"
              ")");
        });
  }

  saveChecklist(Checklist checklist) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Checklist");
    int id = table.first["id"];
    print("selected id : " + id.toString());
    var raw = await db.rawInsert(
        "INSERT Into Checklist (id,name)"
            " VALUES (?,?)",
        [id, checklist.name]);
    print("inserted row in db : " + raw.toString());
    return raw;
  }

  saveCheck(Check check) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Checks");
    int id = table.first["id"];
    print("selected id : " + id.toString());
    var raw = await db.rawInsert(
        "INSERT Into Checks (id,category, nb, state, checklistid)"
            " VALUES (?,?,?,?,?)",
        [id, check.category, check.nb, check.state ? 1 : 0, check.checklistid]);
    print("inserted row in db : " + raw.toString());
    return raw;
  }

  getChecklist(int id) async {
    final db = await database;
    var res = await db.query("Checklist", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Checklist.fromJson(res.first) : null;
  }

  getCheck(int id) async {
    final db = await database;
    var res = await db.query("Checks", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Check.fromJson(res.first) : null;
  }

  Future<List> getAllChecklists() async {
    var db = await database;
    var result = await db.query("Checklist", columns: ["id", "name"]);
    return result.toList();
  }

  deleteChecklist(int id) async {
    var db = await database;
    db.delete("Checklist", where: "id = ?", whereArgs: [id]);
  }

  Future<List> getAllChecks() async {
    var db = await database;
    var result = await db.query("Checks", columns: ["category", "nb", "state"]);
    return result.toList();
  }

  Future<List<Check>> getAllChecksForAChecklistId(int checklistid) async {
    final db = await database;
    List<Check> items = new List();
    var result = await db.query("Checks", where: "checklistid = ?", whereArgs: [checklistid]);
    result.forEach( (jsonCheck) {
      Check c = Check.fromJson(jsonCheck);
      print(c.state);
      items.add(c);
    });
    return items;
  }


}