// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Pictures extends StatelessWidget {
  final Map<String, String> content;
  Pictures({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                content["image"]!,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xef4169D8),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(15)),
                ),
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}