import 'package:flutter/material.dart';

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
                      onPressed: () => Navigator.pushNamed(context, '/checklistHome'),
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

}
