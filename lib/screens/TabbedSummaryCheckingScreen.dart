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
            FlatButton(
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text("Checkliste", style: Theme.of(context).textTheme.body1.apply(
                      color: Color.fromRGBO(31, 204, 115, 1),
                      fontSizeFactor: 1.1
                    ),),
                  ),
                  Icon(
                    Octicons.getIconData("checklist"),
                    size: 25,
                    color: Color.fromRGBO(31, 204, 115, 1),
                  )
                ],
              ),
              onPressed: () =>
        Navigator.pushNamed(context, '/checklistSummary'),
            ),
          ],
          leading: IconButton(
              icon: Icon(
                AntDesign.getIconData("home"),
                size: 25,
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
                  icon: Icon(MaterialCommunityIcons.getIconData("steering"), size: 25,)),
              Tab(
                  text: "Extérieur",
                  icon: Icon(FontAwesome.getIconData("car"), size: 25,)),
              Tab(
                  text: "Moteur",
                  icon: Icon(MaterialCommunityIcons.getIconData("oil"),size: 25,)),
              Tab(text: "Papiers", icon: Icon(Entypo.getIconData("documents"),size: 25,)),
            ],
          ),
        ),
      ),
    );
  }
}
