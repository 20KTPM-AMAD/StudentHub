import 'package:flutter/material.dart';
import 'package:studenthub/dashboard.dart';
import 'package:studenthub/pages/browse_project/post_project_step_4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudentHub',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF12B28C)),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF12B28C)),
          buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF12B28C))),
      home: const Dashboard(),
    );
  }
}
