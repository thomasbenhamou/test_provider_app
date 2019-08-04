import 'package:flutter/material.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:test_provider_app/model/ChecksData.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:test_provider_app/screens/AnalyzeCheckScreen.dart';

class ChecklistItem extends StatelessWidget {
  const ChecklistItem({
    Key key,
    @required this.c,
    @required this.checks,
  }) : super(key: key);

  final Check c;
  final ChecksModel checks;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    void handleOnPress(int checkNb) {
      if (checks.isCheckedInterior(checkNb)) {
        checks.unCheckInterior(checkNb);
      } else {
        checks.checkInterior(checkNb);
      }
    }

    void showAnalyzeCheckScreen(Check check) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnalyzeCheckScreen(check: check),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12, 18, 12, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () => showAnalyzeCheckScreen(c),
                  child: Hero(
                      tag: 'checkHero' + c.nb.toString(),
                      //child: Image.asset(c.image, fit: BoxFit.fitWidth,)
                      child: Icon(Icons.directions_car, size: 80,)
                  ),
                ),
              ),
              constraints: BoxConstraints.expand(width: screenWidth, height: 90),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                  splashColor: checks.isCheckedInterior(c.nb)
                      ? Colors.grey[300]
                      : Color.fromRGBO(31, 204, 115, 1),
                  padding: EdgeInsets.all(0),
                  icon: Icon(MaterialCommunityIcons.getIconData(
                      "checkbox-marked-circle")),
                  color: checks.isCheckedInterior(c.nb)
                      ? Color.fromRGBO(31, 204, 115, 0.95)
                      : Colors.grey[300],
                  iconSize: 55,
                  onPressed: () => handleOnPress(c.nb)),
            ),
          ],
        ),
        InkWell(
          onTap: () => showAnalyzeCheckScreen(c),
          child: Container(
            margin: EdgeInsets.fromLTRB(12, 5, 22, 0),
            child: Text(
              c.title,
              style: Theme.of(context).textTheme.body1,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    );
  }
}
