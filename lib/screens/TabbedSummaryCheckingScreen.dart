import 'package:flutter/material.dart';
import 'InteriorDetailCheckingScreen.dart';
import 'ExteriorDetailCheckingScreen.dart';
import 'EngineDetailCheckingScreen.dart';
import 'PapersDetailCheckingScreen.dart';
import 'package:test_provider_app/model/ChecksData.dart';

class TabbedSummaryCheckingScreen extends StatefulWidget {
  TabbedSummaryCheckingScreen();

  @override
  _TabbedSummaryCheckingScreenState createState() =>
      _TabbedSummaryCheckingScreenState();
}

class _TabbedSummaryCheckingScreenState
    extends State<TabbedSummaryCheckingScreen> {

  ChecksData checksData = new ChecksData();

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Icons.home),
              onPressed: () => Navigator.pushNamed(context, "/")),
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
