import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      length: 3,
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
            Text("Q&A"),
          ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.35,
                floating: false,
                pinned: true,
                snap: false,
                stretch: true,
                centerTitle: true,
                title: Text("Place name"),
                flexibleSpace: FlexibleSpaceBar(
                  background: //flexibleSpaceWidget(context),
                      Image.asset('assets/images/mountain_sunset.jpg',
                          fit: BoxFit.cover),
                  stretchModes: [
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground
                  ],
                ),
                leading: IconButton(
                    icon: Icon(Icons.keyboard_backspace),
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
        body: TabBarView(
          controller: _tabController,
          children: [
            //TODO: Add details widget
            Text("Details Tab"),
            //TODO: Add experiences widget
            Text("Experiences Tab"),
            //TODO: Add Q&A widget
            Text("Q&A Tab"),
          ],
        ),
      ),
    );
  }
}

Widget headerBottomBarWidget(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(0),
    padding: EdgeInsets.all(0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
            child: Icon(Icons.favorite, color: Colors.teal),
            backgroundColor: Colors.white),
        SizedBox(width: 20),
        CircleAvatar(
            child: FaIcon(FontAwesomeIcons.calendarPlus, color: Colors.teal),
            backgroundColor: Colors.white),
      ],
    ),
  );
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
