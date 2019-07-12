import 'package:flutter/material.dart';
import 'package:test_provider_app/widgets/ListViewHistory.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Historique"),
          leading: IconButton(
              icon: Icon(Icons.home), onPressed: () => Navigator.pop(context))),
      body: Container(
        child: ListViewHistory(),
      ),
    );
  }
}
