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
      color: Colors.grey[50],
      margin: EdgeInsets.fromLTRB(5, 10, 5, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
              ),
              child: FlatButton.icon(
                  onPressed: () => uncheckIt(check.nb),
                  icon: Icon(Octicons.getIconData("thumbsdown")),
                  label: Text("Pas bon.")),
            ),
          ),
          Expanded(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(31, 204, 115, 1),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
              ),
              child: FlatButton.icon(
                  onPressed: () => checkIt(check.nb),
                  icon: Icon(Octicons.getIconData("thumbsup")),
                  label: Text("C'est OK!")),
            ),
          ),
        ],
      ),
    );
  }
}
