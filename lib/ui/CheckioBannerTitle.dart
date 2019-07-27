import 'package:flutter/material.dart';
import 'package:test_provider_app/ui/CheckioBanner.dart';

class CheckioBannerTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 85),
      child: Column(
        children: <Widget>[
          CheckioBanner(),
          RichText(
              text: TextSpan(
                  text: "che",
                  style: Theme.of(context).textTheme.title,
                  children: <TextSpan>[
                TextSpan(text: 'ck', style: Theme.of(context).textTheme.headline),
                TextSpan(text: 'io', style: Theme.of(context).textTheme.title),
              ]))
        ],
      ),
    );
  }
}
