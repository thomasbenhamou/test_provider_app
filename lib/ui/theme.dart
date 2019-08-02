import 'package:flutter/material.dart';

final ThemeData CheckioThemeData = new ThemeData(
    primaryColor: Color.fromRGBO(31, 204, 115, 1),
    primaryColorBrightness: Brightness.light,
    accentColor: Color.fromRGBO(72, 139, 73, 1),
    accentColorBrightness: Brightness.light,
    textTheme: TextTheme(
        title: TextStyle(
            color: Color.fromRGBO(31, 204, 115, 1),
            fontFamily: "Advent Pro",
            fontWeight: FontWeight.w700,
          fontSize: 55
        ),
      headline: TextStyle(
          color: Color.fromRGBO(31, 204, 115, 1),
          fontFamily: "Advent Pro",
          fontSize: 77,
          fontWeight: FontWeight.w700
      ),
      subhead: TextStyle(
          color: Color.fromRGBO(31, 204, 115, 1),
          fontFamily: "Advent Pro",
          fontSize: 36,
          fontWeight: FontWeight.w700
      ),
      body1: TextStyle(
        color: Colors.grey[850],
        fontFamily: "Montserrat",
        fontSize: 15
      ),
      button: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 20,
      ),
      display4: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 12,
      ),
      display1: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 33,
        color: Color.fromRGBO(31, 204, 115, 1),
      ),
      overline: TextStyle(
        fontFamily: "Advent Pro",
        fontSize: 28,
      ),
      caption: TextStyle(
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        fontSize: 30,
        color: Colors.grey[300],
      ),
      display2: TextStyle(
        fontFamily: "Montserrat",
        fontSize: 22,
        color: Colors.orangeAccent,
      ),
    ),
    appBarTheme: AppBarTheme(
    color: Colors.grey[50],
      actionsIconTheme: IconThemeData(
        color: Color.fromRGBO(31, 204, 115, 1),
        size: 30
      ),
      iconTheme: IconThemeData(
        color: Color.fromRGBO(31, 204, 115, 1),
        size: 30
      ),
    ),
  tabBarTheme: TabBarTheme(
    labelColor: Color.fromRGBO(31, 204, 115, 1),
    unselectedLabelColor: Colors.grey[400],
  )
);