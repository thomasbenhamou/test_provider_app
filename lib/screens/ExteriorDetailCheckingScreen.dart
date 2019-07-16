import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';

class ExteriorDetailCheckingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var checks = Provider.of<ChecksModel>(context);

    void handleOnPress() {
      if (checks.isCheckedExterior(1)) {
        checks.unCheckExterior(1);
      } else {
        checks.checkExterior(1);
      }
    }

    return Container(
      child: IconButton(
          icon: checks.isCheckedExterior(1)
              ? Icon(Icons.check_box)
              : Icon(Icons.check_box_outline_blank),
          onPressed: handleOnPress),
    );
  }
}
