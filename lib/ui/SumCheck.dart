import 'package:flutter/material.dart';

class SumCheck extends StatelessWidget {

  final int checked;
  final int total;

  SumCheck({this.checked, this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          RichText(
          text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: this.checked.toString(),
              style: Theme.of(context).textTheme.button
            ),
            TextSpan(text: " / ", style: Theme.of(context).textTheme.button),
            TextSpan(
                text: this.total.toString(),
              style: Theme.of(context).textTheme.button.apply(
                color: Colors.grey[500]
              )
            )
          ]
      ),
      )
        ],
      ),
    );
  }
}