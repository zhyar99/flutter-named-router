import 'package:flutter/material.dart';
import 'router.dart';
import 'constants.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter_navigation_simple',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: homeRoute,
      onGenerateRoute: createRoute,
    );
  }
}
