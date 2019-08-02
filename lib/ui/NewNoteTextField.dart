import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';


class NewNoteTextField extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: EdgeInsets.all(35),
      child: Consumer<ChecksModel>(builder: (context, checks, child) {
        return TextField(
          autofocus: checks.note.isEmpty ? false : true,
          minLines: 3,
          maxLines: 3,
          decoration: InputDecoration(
              labelText: "Ajouter une note",
              labelStyle: Theme.of(context).textTheme.caption,
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  borderRadius: BorderRadius.circular(10)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0),
                  borderRadius: BorderRadius.circular(10)),
              fillColor: Colors.grey[100],
              filled: false),
          controller: TextEditingController(text: checks.note),
          onChanged: (content) {
            checks.updateNote(content);
          },
        );
      }),
    );

  }
}