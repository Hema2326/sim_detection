import 'package:flutter/material.dart';
import 'package:generic_error/screens/Number_validate_screen.dart';
import 'package:generic_error/screens/Sim_Detect_screen.dart';
import 'package:generic_error/screens/Validation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SimDetectionScreen(),
    );
  }
}
