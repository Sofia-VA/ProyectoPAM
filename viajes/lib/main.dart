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
            seedColor: Colors.teal, secondary: Color.fromARGB(255, 2, 114, 60)),
        primaryColor: Colors.teal[300],
        iconTheme: IconThemeData(color: Colors.teal[700]),
        listTileTheme: ListTileThemeData(iconColor: Colors.deepPurple[700]),
      ),
      home: HomePage(),
    );
  }
}
