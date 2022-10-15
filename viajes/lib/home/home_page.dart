import 'package:flutter/material.dart';
import 'package:viajes/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // TODO: Add search bar action and animation
              }),
          IconButton(
              icon: Icon(Icons.tune),
              onPressed: () {
                // TODO: Filter/sort actions
              }),
          Padding(padding: EdgeInsets.all(6))
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Row(
            children: [],
          )
        ],
      )),
    );
  }
}
