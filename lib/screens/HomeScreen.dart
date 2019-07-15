import 'package:flutter/material.dart';
import 'package:test_provider_app/service/ChecklistService.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.orangeAccent,
                  child: FlatButton.icon(
                      onPressed: () {
                        ChecklistService.svc.confirmReset(context);
                      },
                      icon: Icon(Icons.fiber_new),
                      label: Text("Nouvelle checklist")),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.redAccent,
                  child: FlatButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/history'),
                      icon: Icon(Icons.history),
                      label: Text("Historique")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  confirmReset(BuildContext context) {

    var checks = Provider.of<ChecksModel>(context);

    if (checks.isPristine == true) {
        checks.unCheckAll();
        Navigator.of(context).popAndPushNamed('/checklistHome');
    } else {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Attention'),
            content: const Text('Créer une nouvelle liste va supprimer les données existantes.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Annuler'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  checks.unCheckAll();
                  Navigator.of(context).popAndPushNamed('/checklistHome');
                },
              ),
            ],
          );
        },
      );
    }

  }*/


}
