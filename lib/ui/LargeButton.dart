import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  String label;

  double width;

  Function onPress;

  LargeButton({this.label, this.width, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
      child: Container(
        height: 130,
        width: this.width,
        child: FlatButton(
          onPressed: () {
            onPress();
          },
          child: Text(
            this.label,
            style: Theme.of(context).textTheme.subhead
          ),
        ),
      ),
    );
  }
}
