import 'package:flutter/material.dart';
import 'package:flutter_application_4/ui/home_screen.dart';

void main() {
  runApp(ForexApp());
}

class ForexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
