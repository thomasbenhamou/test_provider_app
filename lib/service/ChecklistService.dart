import 'package:test_provider_app/db/ChecklistModel.dart';
import 'package:test_provider_app/db/CheckModel.dart';
import 'package:test_provider_app/db/DatabaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:provider/provider.dart';

class ChecklistService {
  ChecklistService._();

  static final ChecklistService svc = ChecklistService._();

  updateChecklist(String name, int id) {
    DBProvider.db.updateChecklist(name, id);
  }

  /// Save a checklist in the DB
  Future<int> saveChecklist(String name) async {
    Checklist c = new Checklist();
    if (name != null && name.isNotEmpty) {
      c.setName(name);
    } else {
      c.setName("Ma checkliste");
    }

    int savedId = await DBProvider.db.saveChecklist(c);
    Checklist saved = await DBProvider.db.getChecklist(savedId);
    print("saved checklist : " + saved.id.toString());
    return savedId;
  }

  /// Save all checks in the DB
  saveChecks(String category, Map<int, bool> checks, int checkListId) async {
    checks.forEach((nb, state) async {
      Check check = new Check();
      check.category = category;
      check.nb = nb;
      check.state = state;
      check.checklistid = checkListId;
      await DBProvider.db.saveCheck(check);
    });
  }

  updateChecks(String category, Map<int, bool> checks, int checkListId) async {
    checks.forEach((nb, state) async {
      Check updatedCheck = new Check();
      updatedCheck.category = category;
      updatedCheck.nb = nb;
      updatedCheck.state = state;
      updatedCheck.checklistid = checkListId;
      await DBProvider.db.updateCheck(updatedCheck);
    });
  }

  confirmReset(BuildContext context) {
    BuildContext overallContext = context;

    var checks = Provider.of<ChecksModel>(overallContext);

    if (checks.isPristine == true) {
      resetCurrentCheckListData(checks);
      Navigator.of(overallContext).pushReplacementNamed('/checklistHome');
    } else {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Attention'),
            content: const Text(
                'Créer une nouvelle liste va supprimer les données existantes.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  resetCurrentCheckListData(checks);
                  Navigator.of(context).popAndPushNamed('/checklistHome');
                },
              ),
            ],
          );
        },
      );
    }
  }

  void resetCurrentCheckListData(ChecksModel checks) {
    checks.unCheckAll();
    checks.resetChecklistIdAndName();
  }
}
