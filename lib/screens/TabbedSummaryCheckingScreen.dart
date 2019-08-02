import 'package:flutter/material.dart';
import 'InteriorDetailCheckingScreen.dart';
import 'ExteriorDetailCheckingScreen.dart';
import 'EngineDetailCheckingScreen.dart';
import 'PapersDetailCheckingScreen.dart';
import 'package:test_provider_app/model/ChecksData.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                icon: Icon(
                  Octicons.getIconData("checklist"),
                  size: 40,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, '/checklistSummary')),
          ],
          leading: IconButton(
              icon: Icon(
                AntDesign.getIconData("home"),
                size: 40,
              ),
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
            labelStyle: Theme.of(context).textTheme.display4,
            indicator: ShapeDecoration(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Color.fromRGBO(200, 200, 200, 0.3)
            ),
            tabs: [
              Tab(
                  text: "Intérieur",
                  icon: Icon(MaterialCommunityIcons.getIconData("steering"), size: 35,)),
              Tab(
                  text: "Extérieur",
                  icon: Icon(FontAwesome.getIconData("car"), size: 35,)),
              Tab(
                  text: "Moteur",
                  icon: Icon(MaterialCommunityIcons.getIconData("oil"),size: 35,)),
              Tab(text: "Papiers", icon: Icon(Entypo.getIconData("documents"),size: 35,)),
            ],
          ),
        ),
      ),
    );
  }
}
