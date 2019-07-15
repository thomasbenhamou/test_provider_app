import 'package:flutter/material.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:provider/provider.dart';
import 'InteriorDetailCheckingScreen.dart';
import 'ExteriorDetailCheckingScreen.dart';
import 'EngineDetailCheckingScreen.dart';
import 'PapersDetailCheckingScreen.dart';
import 'package:test_provider_app/db/DatabaseProvider.dart';

class TabbedSummaryCheckingScreen extends StatelessWidget {

  /**
   * fields and constructor
   */
  int checkListId;
  String checkListName;
  TabbedSummaryCheckingScreen({this.checkListId, this.checkListName});

  @override
  Widget build(BuildContext context) {

    /**
     * checkListId and checkListName are passed by the HistoryScreen
     * at build time
     */
    if (checkListId != null) {

      var checks = Provider.of<ChecksModel>(context);

      /**
       * we update the state using data passed by the HistoryScreen
       */
      // TODO : il faut peut être faire tout ça en dehors du build()
      checks.updateCurrentCheckListId(checkListId);
      checks.updateCurrentCheckListName(checkListName);

      /**
       * we update the state using DB data
       */
      DBProvider.db.getAllChecksForAChecklistId(checkListId).then( (listCheck) {
        listCheck.forEach( (check) {
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

      /**
       * Retrieve DB data for the note
       */
      DBProvider.db.getNote(checkListId).then((noteContent){
      checks.updateNote(noteContent.toString());
    });


      // TODO : looks like it's a stateful widget ??
      checkListId = null;

    }

    /**
     * Building the layout
     */
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.insert_chart),
                label: Text("Résumé"),
                onPressed: () =>
                    Navigator.pushNamed(context, '/checklistSummary')),
          ],
          leading: IconButton(
              icon: Icon(Icons.home), onPressed: () => Navigator.pushNamed(context, "/")),
        ),
        body: TabBarView(
          children: [
            InteriorDetailCheckingScreen(),
            ExteriorDetailCheckingScreen(),
            EngineDetailCheckingScreen(),
            PapersDetailCheckingScreen()
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(text: "Intérieur", icon: Icon(Icons.directions_car)),
              Tab(text: "Extérieur", icon: Icon(Icons.directions_transit)),
              Tab(text: "Moteur", icon: Icon(Icons.directions_bike)),
              Tab(text: "Papiers", icon: Icon(Icons.satellite)),
            ],
          ),
        ),
      ),
    );
  }
}

/*class MainCheckingScreen extends StatelessWidget {
  const MainCheckingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Center(
            child: CircleAvatar(
          backgroundColor: Colors.red,
          radius: 100,
          child: Consumer<ChecksModel>(
            builder: (context, checks, child) {
              int totalChecks = checks.getNbCheckedPapers() +
                  checks.getNbCheckedEngine() +
                  checks.getNbCheckedExterior() +
                  checks.getNbCheckedInterior();
              return Text("Total Checked : " + totalChecks.toString());
            },
          ),
        )),
        Center(
          child: Consumer<ChecksModel>(
            builder: (context, checks, child) {
              bool isAllChecked =
                  checks.getNbCheckedInterior() == checks.interior.length;
              if (isAllChecked) {
                return Row(
                  children: <Widget>[
                    Text("Interior : "),
                    Icon(isAllChecked ? Icons.check : Icons.insert_chart),
                  ],
                );
              } else {
                return Text("Interior Checked : " +
                    checks.getNbCheckedInterior().toString() +
                    "/" +
                    checks.interior.length.toString());
              }
            },
          ),
        ),
        Center(
          child: Consumer<ChecksModel>(
            builder: (context, checks, child) {
              return Text("Exterior Checked : " +
                  checks.getNbCheckedExterior().toString());
            },
          ),
        ),
        Center(
          child: Consumer<ChecksModel>(
            builder: (context, checks, child) {
              return Text(
                  "Papers Checked : " + checks.getNbCheckedPapers().toString());
            },
          ),
        ),
        Center(
          child: Consumer<ChecksModel>(
            builder: (context, checks, child) {
              return Text(
                  "Engine Checked : " + checks.getNbCheckedEngine().toString());
            },
          ),
        ),
      ],
    ));
  }
}*/
