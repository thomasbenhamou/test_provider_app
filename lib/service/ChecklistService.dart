import 'package:test_provider_app/db/ChecklistModel.dart';
import 'package:test_provider_app/db/CheckModel.dart';
import 'package:test_provider_app/db/DatabaseProvider.dart';

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


}