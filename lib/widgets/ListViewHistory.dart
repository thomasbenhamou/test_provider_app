import 'package:flutter/material.dart';
import 'package:test_provider_app/db/DatabaseProvider.dart';
import 'package:test_provider_app/db/ChecklistModel.dart';
import 'package:test_provider_app/screens/TabbedSummaryCheckingScreen.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/ui/NoListDisplay.dart';
import 'package:flutter_icons/flutter_icons.dart';

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

    double width = MediaQuery.of(context).size.width;

    if (items.length == 0) {
      return new NoListDisplay();
    } else {
      return Container(
        child: ListView.builder(
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
                    content: Text(
                      "Supprimé",
                      style: Theme.of(context).textTheme.subhead.apply(
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.orangeAccent,
                    duration: Duration(milliseconds: 600),
                  ));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Color.fromRGBO(31, 204, 115, 1),
                    highlightColor: Color.fromRGBO(31, 204, 115, 1),
                    onTap: () {
                      loadListToContext(checks, position);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TabbedSummaryCheckingScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 85,
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            items[position].name,
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .apply(fontSizeFactor: 1.3, color: Colors.grey[600]),
                          ),
                          Icon(
                            Feather.getIconData("download"),
                            size: 28,
                            color: Colors.grey[600],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
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
