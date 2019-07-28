import 'package:flutter/material.dart';
import 'package:test_provider_app/screens/SummaryCheckingScreen.dart';
import 'package:test_provider_app/screens/InteriorDetailCheckingScreen.dart';
import 'package:test_provider_app/screens/ExteriorDetailCheckingScreen.dart';
import 'package:test_provider_app/screens/PapersDetailCheckingScreen.dart';
import 'package:test_provider_app/screens/EngineDetailCheckingScreen.dart';
import 'package:test_provider_app/screens/AnalyzeCheckScreen.dart';
import 'package:provider/provider.dart';
import 'package:test_provider_app/model/ChecksModel.dart';
import 'package:test_provider_app/screens/TabbedSummaryCheckingScreen.dart';
import 'package:test_provider_app/screens/HomeScreen.dart';
import 'package:test_provider_app/screens/HistoryScreen.dart';
import 'screens/SaveChecklistScreen.dart';
import 'package:test_provider_app/ui/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => ChecksModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Checkio',
        theme: CheckioThemeData,
        initialRoute: '/',
        routes: {
          '/checklistHome': (context) => TabbedSummaryCheckingScreen(),
          '/checklistSummary': (context) => SummaryCheckingScreen(),
          '/': (context) => HomeScreen(),
          '/detailCheckingInterior': (context) =>
              InteriorDetailCheckingScreen(),
          '/detailCheckingExterior': (context) =>
              ExteriorDetailCheckingScreen(),
          '/detailCheckingPapers': (context) => PapersDetailCheckingScreen(),
          '/detailCheckingEngine': (context) => EngineDetailCheckingScreen(),
          '/history': (context) => HistoryScreen(),
          '/saveChecklist': (context) => SaveChecklistScreen(),
          '/analyseCheck' : (context) => AnalyzeCheckScreen(),
        },
      ),
    );
  }
}
