import 'package:flutter/material.dart';
import 'package:viajes/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green, secondary: Colors.greenAccent),
        primaryColor: Colors.lightGreen,
        iconTheme: IconThemeData(color: Colors.white),
        listTileTheme: ListTileThemeData(iconColor: Colors.green[900]),
      ),
      home: HomePage(),
    );
  }
}