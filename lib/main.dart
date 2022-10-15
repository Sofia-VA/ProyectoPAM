// ignore_for_file:, prefer_const_constructors 

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/add_to_calendar.dart';
import 'package:proyecto/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => EventProvider(),
    child: MaterialApp(
      title: 'Material App',
      home: LoginPage(),
    ),
  );
}