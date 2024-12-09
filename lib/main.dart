import 'package:flutter/material.dart';
import 'package:football_live_ticker/presentation/live_tracker_ui.dart';

void main() {
  runApp(const FootballLiveTrackerApp());
}

class FootballLiveTrackerApp extends StatelessWidget {
  const FootballLiveTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Football Live Tracker',
      home: LiveTrackerScreen(),
    );
  }
}
