import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {

  String label;
  Function onPress;

  LargeButton({this.label, this.onPress});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 80,
      width: 800,
      child: FlatButton(
        highlightColor: Colors.grey[100],
        splashColor: Colors.grey[100],
        onPressed: () {
          onPress();
        },
        child: Text(
          this.label,
          style: Theme.of(context).textTheme.subhead
        ),
      ),
    );
  }
}
