import 'package:flutter/material.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:provider/provider.dart';

class SummaryCheckingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/saveChecklist'),
              icon: Icon(Icons.save),
              label: Text("Enregistrer"))
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Center(
              child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 100,
            child: Consumer<ChecksModel>(
              builder: (context, checks, child) {
                int totalChecks = checks.getNbCheckedPapers() +
                    checks.getNbCheckedEngine() +
                    checks.getNbCheckedExterior() +
                    checks.getNbCheckedInterior();
                return Text("Total Checked : " + totalChecks.toString());
              },
            ),
          )),
          Center(
            child: Consumer<ChecksModel>(
              builder: (context, checks, child) {
                bool isAllChecked =
                    checks.getNbCheckedInterior() == checks.interior.length;
                if (isAllChecked) {
                  return Row(
                    children: <Widget>[
                      Text("Interior : "),
                      Icon(isAllChecked ? Icons.check : Icons.insert_chart),
                    ],
                  );
                } else {
                  return Text("Interior Checked : " +
                      checks.getNbCheckedInterior().toString() +
                      "/" +
                      checks.interior.length.toString());
                }
              },
            ),
          ),
          Center(
            child: Consumer<ChecksModel>(
              builder: (context, checks, child) {
                return Text("Exterior Checked : " +
                    checks.getNbCheckedExterior().toString());
              },
            ),
          ),
          Center(
            child: Consumer<ChecksModel>(
              builder: (context, checks, child) {
                return Text("Papers Checked : " +
                    checks.getNbCheckedPapers().toString());
              },
            ),
          ),
          Center(
            child: Consumer<ChecksModel>(
              builder: (context, checks, child) {
                return Text("Engine Checked : " +
                    checks.getNbCheckedEngine().toString());
              },
            ),
          ),
          Center(
            child: newNoteTextField(context),
          ),
        ],
      )),
    );
  }

  newNoteTextField(BuildContext context) {
    return Consumer<ChecksModel>(builder: (context, checks, child) {
      return TextField(
        autofocus: true,
        minLines: 5,
        maxLines: 5,
        controller: TextEditingController(text: checks.note),
        onChanged: (content) {
          checks.updateNote(content);
        },
      );
    });
  }
}
