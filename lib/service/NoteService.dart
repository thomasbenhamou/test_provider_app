import 'package:test_provider_app/db/NoteModel.dart';
import 'package:test_provider_app/db/DatabaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:provider/provider.dart';

class NoteService {
  NoteService._();

  static final NoteService svc = NoteService._();

  Future<int> saveNote(String content, int checkListId) async {
    Note note = new Note();
    note.content = content;
    note.checklistid = checkListId;
    int savedId = await DBProvider.db.saveNote(note);
    print("saved note with id : " + savedId.toString());
    return savedId;
  }

  updateNote(String content, int checkListId) async {
    Note note = new Note();
    note.content = content;
    note.checklistid = checkListId;
    DBProvider.db.updateNote(note);
  }

}