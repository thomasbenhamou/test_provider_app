import 'package:flutter/material.dart';
import 'package:test_provider_app/db/DatabaseProvider.dart';
import 'package:test_provider_app/db/ChecklistModel.dart';
import 'package:test_provider_app/screens/TabbedSummaryCheckingScreen.dart';
import 'package:test_provider_app/service/ChecklistService.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:provider/provider.dart';

class ListViewHistory extends StatefulWidget {
  @override
  _ListViewHistoryState createState() => _ListViewHistoryState();
}

class _ListViewHistoryState extends State<ListViewHistory> {
  List<Checklist> items = new List();

  @override
  void initState() {
    super.initState();
    DBProvider.db.getAllChecklists().then((checklists) {
      setState(() {
        checklists.forEach((checklist) {
          items.add(Checklist.fromJson(checklist));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var checks = Provider.of<ChecksModel>(context);

    if (items.length == 0) {
      return Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.tag_faces,
              size: 70,
              color: Colors.orangeAccent,
            ),
            Text("Vous n'avez pas encore créé de checklist :("),
            FlatButton.icon(
                padding: EdgeInsets.all(20.0),
                onPressed: () {
                  ChecklistService.svc.confirmReset(context);
                },
                icon: Icon(Icons.assignment_turned_in),
                label: Text("Créer une checklist"))
          ],
        )),
      );
    } else {
      return ListView.builder(
          itemCount: items.length,
          padding: EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return Dismissible(
              key: Key(UniqueKey().toString()),
              direction: DismissDirection.endToStart,
              background: dismissibleBackground(),
              onDismissed: (direction) {
                DBProvider.db.deleteChecklist(items[position].id);
                setState(() {
                  items.removeAt(position);
                });
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Supprimé"),
                  backgroundColor: Colors.orangeAccent,
                  duration: Duration(milliseconds: 600),
                ));
              },
              child: InkWell(
                onTap: () {
                  loadListToContext(checks, position);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TabbedSummaryCheckingScreen(),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(items[position].name),
                  ),
                ),
              ),
            );
          });
    }
  }

  void loadListToContext(ChecksModel checks, int position) {
    checks.updateCurrentCheckListId(items[position].id);
    checks.updateCurrentCheckListName(items[position].name);
    /**
      * we update the provider using DB data
      */
    DBProvider.db
        .getAllChecksForAChecklistId(checks.currentCheckListId)
        .then((listCheck) {
      listCheck.forEach((check) {
        if (check.category == "interior") {
          if (check.state) {
            checks.checkInterior(check.nb);
          } else {
            checks.unCheckInterior(check.nb);
          }
        }
        if (check.category == "exterior") {
          if (check.state) {
            checks.checkExterior(check.nb);
          } else {
            checks.unCheckExterior(check.nb);
          }
        }
        if (check.category == "engine") {
          if (check.state) {
            checks.checkEngine(check.nb);
          } else {
            checks.unCheckEngine(check.nb);
          }
        }
        if (check.category == "papers") {
          if (check.state) {
            checks.checkPapers(check.nb);
          } else {
            checks.unCheckPapers(check.nb);
          }
        }
      });
    });

    // Retrieve DB data for the note
    DBProvider.db.getNote(checks.currentCheckListId).then((noteContent) {
      checks.updateNote(noteContent.toString());
    });
  }
}

Widget dismissibleBackground() {
  return Container(
    color: Colors.redAccent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(
              Icons.delete_sweep,
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}
