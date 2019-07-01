import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';

class PapersDetailCheckingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var checks = Provider.of<ChecksModel>(context);

    void handleOnPress() {
      if (checks.isCheckedPapers(2)) {
        checks.unCheckPapers(2);
      } else {
        checks.checkPapers(2);
      }
    }

    return Container(
        child: IconButton(
            icon: checks.isCheckedPapers(2)
                ? Icon(Icons.check_box)
                : Icon(Icons.check_box_outline_blank),
            onPressed: handleOnPress),
      );
  }
  
}
