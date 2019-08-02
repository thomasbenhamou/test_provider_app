import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:test_provider_app/ui/NewNoteTextField.dart';
import 'package:test_provider_app/ui/SummaryRow.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';

class SummaryCheckingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var checks = Provider.of<ChecksModel>(context);

    bool interiorDone = checks.getNbCheckedInterior() == checks.interior.length;
    bool exteriorDone = checks.getNbCheckedExterior() == checks.exterior.length;
    bool engineDone = checks.getNbCheckedEngine() == checks.engine.length;
    bool papersDone = checks.getNbCheckedPapers() == checks.papers.length;

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/saveChecklist'),
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            icon: Icon(
              AntDesign.getIconData("save"),
              size: 40,
            ),
          )
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
            padding: EdgeInsets.all(10),
            child: Text(
              "Ma checkliste",
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Container(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SummaryRow(
                  category: "Intérieur",
                  done: interiorDone,
                  checked: checks.getNbCheckedInterior(),
                  total: checks.interior.length,
                ),
                SummaryRow(
                  category: "Extérieur",
                  done: exteriorDone,
                  checked: checks.getNbCheckedExterior(),
                  total: checks.exterior.length,
                ),
                SummaryRow(
                  category: "Moteur",
                  done: engineDone,
                  checked: checks.getNbCheckedEngine(),
                  total: checks.engine.length,
                ),
                SummaryRow(
                  category: "Papiers",
                  done: papersDone,
                  checked: checks.getNbCheckedPapers(),
                  total: checks.papers.length,
                ),
              ],
            ),
          ),
          Center(
            child: NewNoteTextField(),
          ),

        ],
      )),
    );
  }
}

