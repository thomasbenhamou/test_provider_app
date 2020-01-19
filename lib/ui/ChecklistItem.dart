import 'package:flutter/material.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:test_provider_app/model/ChecksData.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:test_provider_app/screens/AnalyzeCheckScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;

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

    return Container(
      width: screenWidth / 2,

      child: Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey[300]), borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.fromLTRB(9, 30, 9, 9),
                margin: EdgeInsets.all(15),
                height: screenHeight / 7,
                child:  InkWell(
                    onTap: () => showAnalyzeCheckScreen(c),
                    child: Hero(
                        tag: 'checkHero' + c.nb.toString(),
                        child: SvgPicture.asset(c.icon, fit: BoxFit.fitHeight,)
                    ),
                  ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.grey[50],
                  child: IconButton(
                    highlightColor: Colors.transparent,
                      splashColor: checks.isCheckedInterior(c.nb) == null
                          ? Colors.grey[300]
                          : Color.fromRGBO(31, 204, 115, 1),
                      padding: EdgeInsets.all(0),
                      icon: Icon(MaterialCommunityIcons.getIconData(
                          "checkbox-marked-circle")),
                      color: checks.isCheckedInterior(c.nb) == null
                          ? Color.fromRGBO(31, 204, 115, 0.95)
                          : Colors.grey[300],
                      iconSize: 40,
                      onPressed: () => handleOnPress(c.nb)),
                ),
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
      ),
    );
  }
}
