import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:test_provider_app/service/ChecklistService.dart';
import 'package:test_provider_app/service/NoteService.dart';
import 'package:test_provider_app/ui/LargeButton.dart';

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

    // Getting the state
    var checks = Provider.of<ChecksModel>(context);
    Map<int, bool> interior = checks.interior;
    Map<int, bool> exterior = checks.exterior;
    Map<int, bool> engine = checks.engine;
    Map<int, bool> papers = checks.papers;
    var note = checks.note;

    //Update the state
    if (checks.currentCheckListId != null) {
      ChecklistService.svc.updateChecklist(
          checks.currentCheckListName, checks.currentCheckListId);
      ChecklistService.svc
          .updateChecks("interior", interior, checks.currentCheckListId);
      ChecklistService.svc
          .updateChecks("exterior", interior, checks.currentCheckListId);
      ChecklistService.svc
          .updateChecks("engine", interior, checks.currentCheckListId);
      ChecklistService.svc
          .updateChecks("papers", interior, checks.currentCheckListId);
      NoteService.svc.updateNote(note, checks.currentCheckListId);
    } else {
      // Save new list
      checkListId =
          await ChecklistService.svc.saveChecklist(checks.currentCheckListName);
      ChecklistService.svc.saveChecks("interior", interior, checkListId);
      ChecklistService.svc.saveChecks("exterior", exterior, checkListId);
      ChecklistService.svc.saveChecks("engine", engine, checkListId);
      ChecklistService.svc.saveChecks("papers", papers, checkListId);
      NoteService.svc.saveNote(note, checkListId);
    }

    setState(() {
      isSaving = false;
      isSaveDone = true;
    });

    if (isSaveDone) {
      setState(() {
        isSaveDone = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Sauvegardé", style: Theme.of(context).textTheme.subhead.apply(
          color: Colors.white,
        ), textAlign: TextAlign.center,),
        duration: Duration(milliseconds: 600),
        backgroundColor: Colors.green,
      ));
      new Timer(new Duration(milliseconds: 1000), returnToSummary);
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
    return Column(
      children: <Widget>[
        Consumer<ChecksModel>(builder: (context, checks, child) {
          return Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            padding: EdgeInsets.all(20),
            child: TextField(
              style: Theme.of(context).textTheme.button,
              autofocus: true,
              maxLength: 20,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ma checklist',
              ),
              controller:
                  TextEditingController(text: checks.currentCheckListName),
              onChanged: (content) {
                checks.updateCurrentCheckListName(content);
              },
            ),
          );
        }),
        LargeButton(
          label: "Enregistrer",
            onPress: _saveToDb,
            )
      ],
    );
  }
}
