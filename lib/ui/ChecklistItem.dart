import 'package:flutter/material.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:test_provider_app/model/ChecksData.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
    void handleOnPress(int checkNb) {
      if (checks.isCheckedInterior(checkNb)) {
        checks.unCheckInterior(checkNb);
      } else {
        checks.checkInterior(checkNb);
      }
    }

    void showAnalyzeCheckScreen(String category, int checkNb) {
      // TODO
    }

    return Container(
      margin: EdgeInsets.fromLTRB(7, 0, 7, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(12, 18, 12, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(c.image), fit: BoxFit.fitWidth)),
                constraints: BoxConstraints.expand(width: 400, height: 140),
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
          Container(
            margin: EdgeInsets.fromLTRB(22, 5, 22, 0),
            child: Text(
              c.description,
              style: Theme.of(context).textTheme.body1,
            ),
          ),
        ],
      ),
    );
  }
}