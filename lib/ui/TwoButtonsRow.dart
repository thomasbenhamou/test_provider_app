import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksData.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:flutter_icons/flutter_icons.dart';


class TwoButtonsRow extends StatelessWidget {
  const TwoButtonsRow({
    Key key,
    @required this.check,
  }) : super(key: key);

  final Check check;

  @override
  Widget build(BuildContext context) {

    var checks = Provider.of<ChecksModel>(context);

    void uncheckIt(int checkNb) {
      checks.unCheckInterior(checkNb);
      Navigator.of(context).pop();
    }

    void checkIt(int checkNb) {
      checks.checkInterior(checkNb);
      Navigator.of(context).pop();
    }

    return Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 70,
              child: FloatingActionButton(
                heroTag: "button" + check.nb.toString() + "_1",
                backgroundColor: Colors.redAccent,
                  onPressed: () => uncheckIt(check.nb),
                  child: Icon(Octicons.getIconData("thumbsdown"))),
            ),
          ),
          Expanded(
            child: Container(
              height: 70,
              child: FloatingActionButton(
                heroTag: "button" + check.nb.toString() + "_2",
                backgroundColor: Colors.greenAccent,
                  onPressed: () => checkIt(check.nb),
                  child: Icon(Octicons.getIconData("thumbsup"))),
            ),
          ),
        ],
      ),
    );
  }
}
