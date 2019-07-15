import 'package:test_provider_app/db/ChecklistModel.dart';
import 'package:test_provider_app/db/CheckModel.dart';
import 'package:test_provider_app/db/DatabaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:provider/provider.dart';

class ChecklistService {
  ChecklistService._();

  static final ChecklistService svc = ChecklistService._();

  updateChecklist(String name, int id) async {
    await DBProvider.db.updateChecklist(name, id);
  }

  /**
   * Save a checklist in the DB
   */
  Future<int> saveChecklist(String name) async {
    Checklist checklist2 = new Checklist();
    checklist2.setName(name);
    int savedId = await DBProvider.db.saveChecklist(checklist2);
    Checklist saved = await DBProvider.db.getChecklist(savedId);
    print("saved checklist : " + saved.id.toString());
    return savedId;
  }

  /**
   * Save all checks in the DB
   */
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

  confirmReset(BuildContext context) {

    BuildContext overallContext = context;

    var checks = Provider.of<ChecksModel>(overallContext);

    if (checks.isPristine == true) {
      resetCurrentCheckListData(checks);
      Navigator.of(overallContext).popAndPushNamed('/checklistHome');

    } else {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Attention'),
            content: const Text('Créer une nouvelle liste va supprimer les données existantes.'),
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