import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viajes/home/place_card.dart';
import 'package:viajes/nav_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.25,
                  floating: false,
                  pinned: true,
                  actions: <Widget>[
                    IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.featherPointed)),
                    Padding(padding: EdgeInsets.all(6))
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                          // decoration: BoxDecoration(
                          //     image: DecorationImage(
                          //         image: AssetImage(
                          //             'assets/images/travel_banner.jpg'),
                          //         fit: BoxFit.cover,
                          //         alignment: Alignment(0, 11),
                          //         colorFilter: ColorFilter.mode(
                          //             Color.fromARGB(255, 42, 37, 37)
                          //                 .withOpacity(0.3),
                          //             BlendMode.srcOver))),
                          child: Center(
                              child: Text("Find a new experience",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 22))))),
                  bottom: AppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: kToolbarHeight + 30,
                    title: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            width: double.infinity,
                            height: 40,
                            child: Center(child: _searchBar(context))),
                        SizedBox(height: 5)
                      ],
                    ),
                  )),
            ];
          },
          body: CustomScrollView(slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Categories",
                              style: Theme.of(context).textTheme.headline6)),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: _categoriesIcons()),
                      SizedBox(height: 20),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Nearby",
                              style: Theme.of(context).textTheme.headline6)),
                      SizedBox(height: 20),
                      SizedBox(height: 140, child: _nearbyPlaces())
                    ],
                  )),
            ]))
          ]),
        ));
  }

  Widget _categoriesIcons() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(children: [
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.amberAccent[100],
          child: FaIcon(
            FontAwesomeIcons.personBiking,
            size: 26.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.amberAccent[100],
          child: FaIcon(
            FontAwesomeIcons.personBiking,
            size: 26.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.amberAccent[100],
          child: FaIcon(
            FontAwesomeIcons.personBiking,
            size: 26.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.amberAccent[100],
          child: FaIcon(
            FontAwesomeIcons.personBiking,
            size: 26.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.amberAccent[100],
          child: FaIcon(
            FontAwesomeIcons.personBiking,
            size: 26.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.amberAccent[100],
          child: FaIcon(
            FontAwesomeIcons.personBiking,
            size: 26.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.amberAccent[100],
          child: FaIcon(
            FontAwesomeIcons.personBiking,
            size: 26.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.amberAccent[100],
          child: FaIcon(
            FontAwesomeIcons.personBiking,
            size: 26.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.amberAccent[100],
          child: FaIcon(
            FontAwesomeIcons.personBiking,
            size: 26.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        )
      ]),
    );
  }

  Widget _searchBar(BuildContext context) {
    return TextField(
      enableSuggestions: true,
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search a place",
        contentPadding: EdgeInsets.all(0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              //TODO: Search
            }),
        suffixIcon: IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              // TODO: Filter/sort actions
            }),
      ),
      onSubmitted: (value) {
        // TODO: Search
      },
    );
  }

  Widget _nearbyPlaces() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.all(5),
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: EdgeInsets.only(right: 10), child: LocationCard());
        });
  }
}
