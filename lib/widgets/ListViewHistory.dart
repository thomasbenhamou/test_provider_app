import 'package:flutter/material.dart';
import 'package:test_provider_app/db/DatabaseProvider.dart';
import 'package:test_provider_app/db/ChecklistModel.dart';
import 'package:test_provider_app/screens/TabbedSummaryCheckingScreen.dart';
import 'package:test_provider_app/service/ChecklistService.dart';

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
    if (items.length == 0) {
      return Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 70, color: Colors.orangeAccent,),
            Text("Vous n'avez pas encore créé de checklist :("),
            FlatButton.icon(
              padding: EdgeInsets.all(20.0),
                onPressed: () {
                  ChecklistService.svc.confirmReset(context);
                },
                icon: Icon(Icons.assignment_turned_in),
                label: Text("Créer une checklist")
            )
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TabbedSummaryCheckingScreen(checkListId: items[position].id),
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
