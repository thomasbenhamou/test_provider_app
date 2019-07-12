import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:test_provider_app/db/DatabaseProvider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:test_provider_app/service/ChecklistService.dart';

class SaveChecklistForm extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<SaveChecklistForm> {
  final myController = TextEditingController();
  bool isSaving = false;
  bool isSaveDone = false;

  _saveToDb() async {
    setState(() {
      isSaving = true;
    });

    int checkListId = await ChecklistService.svc.saveChecklist(myController.text);

    Map<int, bool> interior = Provider.of<ChecksModel>(context).interior;
    Map<int, bool> exterior = Provider.of<ChecksModel>(context).exterior;
    Map<int, bool> engine = Provider.of<ChecksModel>(context).engine;
    Map<int, bool> papers = Provider.of<ChecksModel>(context).papers;

    ChecklistService.svc.saveChecks("interior", interior, checkListId);
    ChecklistService.svc.saveChecks("exterior", exterior, checkListId);
    ChecklistService.svc.saveChecks("engine", engine, checkListId);
    ChecklistService.svc.saveChecks("papers", papers, checkListId);

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
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          maxLength: 20,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Ma checklist'),
          controller: myController,
        ),
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


