import 'dart:math';

import 'package:flutter/material.dart';

class LocationExperiences extends StatelessWidget {
  const LocationExperiences({super.key});

  @override
  Widget build(BuildContext context) {
    final List _gridItems = List.generate(90, (i) => "Experience $i");
    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 1,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Card(
                // generate blues with random shades
                color: Colors.teal[Random().nextInt(4) * 100],
                child: Container(
                  alignment: Alignment.center,
                  child: Text(_gridItems[index]),
                ),
              );
            },
            childCount: _gridItems.length,
          ),
        ),
      ],
    );
  }
}
