import 'package:flutter/material.dart';
import 'package:test_provider_app/widgets/SaveChecklistForm.dart';

class SaveChecklistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sauvegarder"),
      ),
      body: Container(child: SaveChecklistForm()),
    );
  }
}
