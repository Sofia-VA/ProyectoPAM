import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viajes/home/location/details_tab.dart';
import 'package:viajes/home/location/experiences_tab.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabBar get _tabBar => TabBar(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
          labelPadding: EdgeInsets.all(10),
          controller: _tabController,
          tabs: [
            Text("Details"),
            Text("Experiences"),
            //Text("Q&A"),
          ]);

  @override
  Widget build(BuildContext context) {
    double expandedHeight = MediaQuery.of(context).size.height * 0.35;

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: expandedHeight,
                floating: false,
                pinned: true,
                snap: false,
                stretch: true,
                centerTitle: true,
                // TODO: Fading title
                title: innerBoxIsScrolled ? Text("Place name") : Text(""),
                flexibleSpace: FlexibleSpaceBar(
                  background: flexibleSpaceWidgetv2(
                      context, expandedHeight), //flexibleSpaceWidget(context),

                  stretchModes: [
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground
                  ],
                ),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      //Navigator.pop(context);
                    }),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.featherPointed)),
                ],
                bottom: _tabBar),
          ];
        },
        body: Column(children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                LocationDetails(),
                //Text("Experiences Tab"),
                LocationExperiences(),
                //TODO: Rethink Q&A widget
                //Text("Q&A Tab"),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget flexibleSpaceWidgetv2(BuildContext context, double expandedHeight) {
    return Container(
        height: expandedHeight + kToolbarHeight,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/mountain_sunset.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.srcOver))),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Place Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 25)),
                  Text('City, Country',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.locationDot,
                          color: Colors.white, size: 30)),
                  SizedBox(width: 20),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 30,
                      )),
                  SizedBox(width: 20),
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.calendarPlus,
                          color: Colors.white, size: 30)),
                ],
              )
            ],
          ),
        ));
  }
}

Widget flexibleSpaceWidget(BuildContext context) {
  return Stack(clipBehavior: Clip.antiAliasWithSaveLayer, children: [
    Container(
      color: Colors.teal,
    ),
    Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/mountain_sunset.jpg'),
        fit: BoxFit.cover,
        // colorFilter: ColorFilter.mode(
        //     Colors.black.withOpacity(0.5), BlendMode.srcOver)
      )),
      child: null,
    ),
    Positioned(
      top: MediaQuery.of(context).size.height / 4.9,
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width / 1.5,
      child: Container(
        child: ListTile(
          title: Text('Place Name',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          subtitle:
              Text('City, Country', style: TextStyle(color: Colors.white)),
          leading: IconButton(
              onPressed: () {},
              icon: FaIcon(FontAwesomeIcons.locationDot,
                  size: 30, color: Colors.white)),
        ),
        decoration: BoxDecoration(
          color: Colors.teal[800],
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        height: MediaQuery.of(context).size.height / 12,
      ),
    ),
  ]);
}
