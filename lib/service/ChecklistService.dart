import 'package:test_provider_app/db/ChecklistModel.dart';
import 'package:test_provider_app/db/CheckModel.dart';
import 'package:test_provider_app/db/DatabaseProvider.dart';
import 'package:flutter/material.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:provider/provider.dart';

class ChecklistService {
  ChecklistService._();

  static final ChecklistService svc = ChecklistService._();

  Future<int> saveChecklist(String name) async {
    Checklist checklist2 = new Checklist();
    checklist2.setName(name);
    int savedId = await DBProvider.db.saveChecklist(checklist2);
    Checklist saved = await DBProvider.db.getChecklist(savedId);
    print("saved checklist : " + saved.name);
    return savedId;
  }

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

    var checks = Provider.of<ChecksModel>(context);

    if (checks.isPristine == true) {
      checks.unCheckAll();
      Navigator.of(context).popAndPushNamed('/checklistHome');
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
                  checks.unCheckAll();
                  Navigator.of(context).popAndPushNamed('/checklistHome');
                },
              ),
            ],
          );
        },
      );
    }

  }


}