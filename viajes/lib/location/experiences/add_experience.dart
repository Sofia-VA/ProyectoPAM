// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:viajes/location/experiences/pictures.dart';

class AddExperience extends StatefulWidget {
  const AddExperience({super.key});

  @override
  State<AddExperience> createState() => _AddExperience();
}

class _AddExperience extends State<AddExperience> {
  final List<Map<String, String>> _listElements = [
    {
      "image":
          "https://cdn.pixabay.com/photo/2020/05/24/06/54/dumbo-5212670_960_720.jpg",
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2017/12/25/12/45/architecture-3038332_960_720.jpg",
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2020/05/24/06/54/dumbo-5212671_960_720.jpg",
    },
    {
      "image":
          "https://cdn.pixabay.com/photo/2018/10/05/21/27/brooklyn-bridge-3726892_960_720.jpg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Experience", style: TextStyle(color: Colors.black)),
        backgroundColor: Colours.olive,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colours.white,
        ),
        child: ListView(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Add your pictures: ",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            _picturesArea(context),
            SizedBox(height: 2),
            Form(
                child: Column(
              children: <Widget>[
                TextFormField(
                    decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                )),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                  labelText: 'Country',
                  hintText: 'Country',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                )),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                  labelText: 'City',
                  hintText: 'City',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                )),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                )),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                  labelText: 'ImageUrl',
                  hintText: 'ImageUrl',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                )),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                  labelText: 'Location',
                  hintText: 'Location',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                )),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                  labelText: 'Price',
                  hintText: 'Price',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                )),
              ],
            )),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextButton(
                  onPressed: () {
                    null;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      color: Colours.olive,
                    ),
                    child: Text("Post",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _picturesArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      height: MediaQuery.of(context).size.height / 4,
      child: _picturesList(),
    );
  }

  Widget _picturesList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _listElements.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => {
            //show dialog
          },
          child: Pictures(
            content: _listElements[index],
          ),
        );
      },
    );
  }
}
