import 'package:flutter/material.dart';
import 'package:test_provider_app/ui/CheckioRectTile.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CheckioBanner extends StatelessWidget {

  const CheckioBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                height: 60,
                color: Colors.grey[100],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CheckioRectTile(icon: MaterialCommunityIcons.getIconData("car-convertible")),
                  CheckioRectTile(icon: MaterialCommunityIcons.getIconData("car-hatchback")),
                  CheckioRectTile(icon: MaterialCommunityIcons.getIconData("car-estate")),
                  CheckioRectTile(icon: MaterialCommunityIcons.getIconData("car-sports")),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}