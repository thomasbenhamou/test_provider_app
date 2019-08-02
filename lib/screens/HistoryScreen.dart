import 'package:flutter/material.dart';
import 'package:test_provider_app/widgets/ListViewHistory.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: Text("Historique", style: Theme.of(context).textTheme.subhead,),
          ),
      body: Container(
        color: Colors.grey[100],
        width: width,
        child: ListViewHistory(),
      ),
    );
  }
}

