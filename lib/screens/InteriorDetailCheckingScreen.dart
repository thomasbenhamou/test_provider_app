import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:test_provider_app/model/ChecksData.dart';

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
                    return Card(
                      child: Column(
                        children: <Widget>[
                          Image(image: AssetImage(c.image),
                          fit: BoxFit.fitHeight,
                            height: 80,
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                  icon: checks.isCheckedInterior(c.nb)
                                      ? Icon(Icons.check_box)
                                      : Icon(Icons.check_box_outline_blank),
                                  onPressed: () => handleOnPress(c.nb)),
                              Text(c.description)
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          }),
    );

  }
}
