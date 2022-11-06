import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viajes/home/icon_button.dart';
import 'package:viajes/home/location_card.dart';
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
                      Container(height: 65, child: _categoriesIcons()),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Nearby",
                              style: Theme.of(context).textTheme.headline6)),
                      SizedBox(height: 20),
                      Container(height: 170, child: _nearbyPlaces()),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Popular",
                              style: Theme.of(context).textTheme.headline6)),
                      SizedBox(height: 20),
                      SizedBox(height: 160, child: LocationCard(width: 0.9)),
                    ],
                  )),
            ]))
          ]),
        ));
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

  Widget _categoriesIcons() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 5),
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
        return CustomIconButton(
          iconID: 69690,
          iconColor: Theme.of(context).iconTheme.color,
          buttonColor: Colors.amberAccent[100],
          buttonPressed: () {
            print('alo');
          },
        );
      },
    );
  }

  Widget _nearbyPlaces() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(left: 5, bottom: 10),
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              margin: EdgeInsets.only(right: 10),
              child: LocationCard(width: 0.4));
        });
  }
}
