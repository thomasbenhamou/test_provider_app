import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_provider_app/db/ChecklistModel.dart';
import 'package:test_provider_app/db/CheckModel.dart';
import 'package:test_provider_app/db/NoteModel.dart';

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
      await db.execute("CREATE TABLE Notes ("
          "id INTEGER PRIMARY KEY,"
          "content TEXT,"
          "checklistid INTEGER,"
          "FOREIGN KEY(checklistid) REFERENCES Checklist(id)"
          ")");
    });
  }

  saveNote(Note note) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Notes (content,checklistid)"
        " VALUES (?,?)",
        [note.content, note.checklistid]);
    print("inserted notes in db : " +
        note.content +
        "listId : " +
        raw.toString());
    return raw;
  }

  saveChecklist(Checklist checklist) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Checklist (name)"
        " VALUES (?)",
        [checklist.name]);
    print("inserted row in db : " + raw.toString());
    return raw;
  }

  updateChecklist(String name, int id) async {
    final db = await database;
    Checklist c = new Checklist();
    c.id = id;
    c.name = name;
    await db
        .update("Checklist", c.toJson(), where: "id = ?", whereArgs: [c.id]);
  }

  updateCheck(Check c) async {
    final db = await database;
    await db.update("Checks", {"state": c.state ? 1 : 0},
        where: "checklistid = ? AND category =? AND nb = ?",
        whereArgs: [c.checklistid, c.category, c.nb]);
  }

  updateNote(Note n) async {
    final db = await database;
    await db.update("Notes", {"content": n.content},
        where: "checklistid = ?", whereArgs: [n.checklistid]);
  }

  saveCheck(Check check) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Checks (category, nb, state, checklistid)"
        " VALUES (?,?,?,?)",
        [check.category, check.nb, check.state ? 1 : 0, check.checklistid]);
    print("inserted check in db : " + raw.toString());
    return raw;
  }

  Future<Checklist> getChecklist(int id) async {
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
    db.delete("Notes", where: "checklistid = ?", whereArgs: [id]);
    db.delete("Checks", where: "checklistid = ?", whereArgs: [id]);
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
    var result = await db
        .query("Checks", where: "checklistid = ?", whereArgs: [checklistid]);
    result.forEach((jsonCheck) {
      Check c = Check.fromJson(jsonCheck);
      print("db : " + c.state.toString());
      items.add(c);
    });
    return items;
  }

  Future<String> getNote(int checklistid) async {
    final db = await database;
    List<String> notes = new List();
    var res = await db
        .query("Notes", where: "checklistid = ?", whereArgs: [checklistid]);
    res.forEach((jsonNote) {
      Note n = Note.fromJson(jsonNote);
      print("db : " + n.content);
      notes.add(n.content);
    });
    return notes.isEmpty ? null : notes.first;
  }
}
