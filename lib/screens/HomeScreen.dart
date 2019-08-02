import 'package:flutter/material.dart';
import 'package:test_provider_app/service/ChecklistService.dart';
import 'package:test_provider_app/ui/LargeButton.dart';
import 'package:test_provider_app/ui/CheckioBannerTitle.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CheckioBannerTitle(),
            ContinueButton(),
            LargeButton(
              label: "Nouvelle checkliste",
              onPress: () {
                ChecklistService.svc.confirmReset(context);
              },
            ),
            LargeButton(
              label: "Historique",
              onPress: () => Navigator.pushNamed(context, '/history'),
            ),
          ],
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var checks = Provider.of<ChecksModel>(context);
    if (!checks.isPristine) {
      return LargeButton(
        label: "Continuer ma checkliste",
        onPress: () {
          Navigator.of(context).pushReplacementNamed('/checklistHome');
        },
      );
    } else {
      return new Container();
    }
  }
}
