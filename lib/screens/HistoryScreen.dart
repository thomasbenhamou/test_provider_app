import 'package:flutter/material.dart';
import 'package:test_provider_app/widgets/ListViewHistory.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var checks = Provider.of<ChecksModel>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text("Historique"),
          leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                checks.unCheckAll();
                Navigator.of(context).pushReplacementNamed('/');
              })),
      body: Container(
        child: ListViewHistory(),
      ),
    );
  }
}
