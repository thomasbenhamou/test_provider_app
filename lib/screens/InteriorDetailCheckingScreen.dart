import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:test_provider_app/model/ChecksData.dart';
import 'package:test_provider_app/ui/ChecklistItem.dart';

class InteriorDetailCheckingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var checks = Provider.of<ChecksModel>(context);


    return Container(
      child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('data/interior_checks.json'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              ChecksData cd = checksDataFromJson(snapshot.data.toString());
              List<Check> checksData = cd.checks;
              return ListView.builder(
                  itemCount: checksData == null ? 0 : checksData.length,
                  itemBuilder: (BuildContext context, int index) {
                    Check c = checksData[index];
                    return new ChecklistItem(c: c, checks: checks);
                  });
            } else {
              return CircularProgressIndicator();
            }
          }),
    );

  }
}


