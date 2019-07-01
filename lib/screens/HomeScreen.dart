import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FlatButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/checklistHome'),
              icon: Icon(Icons.fiber_new),
              label: Text("Nouvelle checklist")),
        ),
      ),
    );
  }
}
