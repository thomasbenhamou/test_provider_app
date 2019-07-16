import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';

class InteriorDetailCheckingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var checks = Provider.of<ChecksModel>(context);

    void handleOnPress(int checkNb) {
      if (checks.isCheckedInterior(checkNb)) {
        checks.unCheckInterior(checkNb);
      } else {
        checks.checkInterior(checkNb);
      }
    }

    return Container(
      child: Column(
        children: <Widget>[
          IconButton(
              icon: checks.isCheckedInterior(1)
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
              onPressed: () => handleOnPress(1)),
          IconButton(
              icon: checks.isCheckedInterior(2)
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
              onPressed: () => handleOnPress(2)),
          IconButton(
              icon: checks.isCheckedInterior(3)
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
              onPressed: () => handleOnPress(3)),
        ],
      ),
    );
  }
}
