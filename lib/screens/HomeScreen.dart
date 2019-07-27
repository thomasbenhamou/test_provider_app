import 'package:flutter/material.dart';
import 'package:test_provider_app/service/ChecklistService.dart';
import 'package:test_provider_app/ui/LargeButton.dart';
import 'package:test_provider_app/ui/CheckioBannerTitle.dart';

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
            LargeButton(
              label: "Nouvelle checkliste",
              width: 330,
              onPress: () {
                ChecklistService.svc.confirmReset(context);
              },
            ),
            LargeButton(
              label: "Historique",
              width: 230,
              onPress: () => Navigator.pushNamed(context, '/history'),
            ),
          ],
        ),
      ),
    );
  }
}
