import 'package:flutter/material.dart';

class CheckioRectTile extends StatelessWidget {

  IconData icon;

  CheckioRectTile({this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
            clipper: new CustomHalfCircleClipper(),
            child: new Container(
              height: 50.0,
              width: 50.0,
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: new BoxDecoration(
                  color: Color.fromRGBO(31, 204, 115, 1),
                  borderRadius: BorderRadius.circular(150.0)
              ),
            )),
        Container(
          color: Color.fromRGBO(31, 204, 115, 1),
          height: 80,
          width: 50,
          margin: EdgeInsets.fromLTRB(5, 25, 5, 0),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          width: 50,
          height: 120,
          child: Icon(this.icon, color: Colors.white, size: 45,),
        )
      ],
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
