import 'package:flutter/material.dart';
import 'package:test_provider_app/screens/SummaryCheckingScreen.dart';
import 'package:test_provider_app/screens/InteriorDetailCheckingScreen.dart';
import 'package:test_provider_app/screens/ExteriorDetailCheckingScreen.dart';
import 'package:test_provider_app/screens/PapersDetailCheckingScreen.dart';
import 'package:test_provider_app/screens/EngineDetailCheckingScreen.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:test_provider_app/screens/TabbedSummaryCheckingScreen.dart';
import 'package:test_provider_app/screens/HomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => ChecksModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
        '/checklistHome': (context) => TabbedSummaryCheckingScreen(),
          '/checklistSummary' : (context) => SummaryCheckingScreen(),
          '/': (context) => HomeScreen(),
        '/detailCheckingInterior': (context) => InteriorDetailCheckingScreen(),
          '/detailCheckingExterior': (context) => ExteriorDetailCheckingScreen(),
          '/detailCheckingPapers': (context) => PapersDetailCheckingScreen(),
          '/detailCheckingEngine': (context) => EngineDetailCheckingScreen(),
      },
      ),
    );
  }
}

