import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/register_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture Store',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RegisterScreen(),
    );
  }
}