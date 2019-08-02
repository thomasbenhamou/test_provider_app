import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:test_provider_app/service/ChecklistService.dart';
import 'package:test_provider_app/ui/LargeButton.dart';

class NoListDisplay extends StatelessWidget {
  const NoListDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(10),
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  AntDesign.getIconData("frowno"),
                  size: 70,
                  color: Colors.orangeAccent,
                ),
                Text(
                  "Oh non, vous n'avez pas encore créé de checklist",
                  style: Theme.of(context).textTheme.display2,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Expanded(
              child: LargeButton(
            label: "Nouvelle checklist",
            onPress: () => ChecklistService.svc.confirmReset(context),
          ))
        ],
      ),
    );
  }
}
