import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';

class EngineDetailCheckingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var checks = Provider.of<ChecksModel>(context);

    void handleOnPress(int checkNb) {
      if (checks.isCheckedEngine(checkNb)) {
        checks.unCheckEngine(checkNb);
      } else {
        checks.checkEngine(checkNb);
      }
    }

    bool is1Checked = checks.isCheckedEngine(1);
    bool is2Checked = checks.isCheckedEngine(2);

    return Container(
        child: Column(
          children: <Widget>[
            IconButton(
                icon: is1Checked
                    ? Icon(Icons.check_box)
                    : Icon(Icons.check_box_outline_blank),
                onPressed: () => handleOnPress(1)),
            IconButton(
                icon: is2Checked
                    ? Icon(Icons.check_box)
                    : Icon(Icons.check_box_outline_blank),
                onPressed: () => handleOnPress(2)),
          ],
        ),
      );
  }
  
}
