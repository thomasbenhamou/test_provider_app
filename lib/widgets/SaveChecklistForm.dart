import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:test_provider_app/db/DatabaseProvider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:test_provider_app/service/ChecklistService.dart';
import 'package:test_provider_app/service/NoteService.dart';
import 'package:test_provider_app/db/ChecklistModel.dart';

class SaveChecklistForm extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<SaveChecklistForm> {
  var myController = TextEditingController();

  bool isSaving = false;
  bool isSaveDone = false;

  _saveToDb() async {
    setState(() {
      isSaving = true;
    });

    int checkListId;

    var checks = Provider.of<ChecksModel>(context);

    if (Provider.of<ChecksModel>(context).currentCheckListId != null) {
      await ChecklistService.svc.updateChecklist(
          checks.currentCheckListName, checks.currentCheckListId);
    } else {
      checkListId =
          await ChecklistService.svc.saveChecklist(checks.currentCheckListName);
    }

    Map<int, bool> interior = checks.interior;
    Map<int, bool> exterior = checks.exterior;
    Map<int, bool> engine = checks.engine;
    Map<int, bool> papers = checks.papers;

    ChecklistService.svc.saveChecks("interior", interior, checkListId);
    ChecklistService.svc.saveChecks("exterior", exterior, checkListId);
    ChecklistService.svc.saveChecks("engine", engine, checkListId);
    ChecklistService.svc.saveChecks("papers", papers, checkListId);

    var note = checks.note;
    NoteService.svc.saveNote(note, checkListId);

    setState(() {
      isSaving = false;
      isSaveDone = true;
    });

    if (isSaveDone) {
      setState(() {
        isSaveDone = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Sauvegardé"),
        duration: Duration(milliseconds: 600),
        backgroundColor: Colors.greenAccent,
      ));
      new Timer(new Duration(milliseconds: 700), returnToSummary);
    }
  }

  void returnToSummary() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var checks = Provider.of<ChecksModel>(context);

    return Column(
      children: <Widget>[
        Consumer<ChecksModel>(builder: (context, checks, child) {
          return TextField(
            autofocus: true,
            maxLength: 20,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Ma checklist',
            ),
            controller:
                TextEditingController(text: checks.currentCheckListName),
            onChanged: (content) {
              checks.updateCurrentCheckListName(content);
            },
          );
        }),
        FlatButton.icon(
            onPressed: _saveToDb,
            icon: isSaving
                ? Icon(Icons.cached)
                : isSaveDone ? Icon(Icons.check) : Icon(Icons.save),
            label: Text("Enregistrer"))
      ],
    );
  }
}
