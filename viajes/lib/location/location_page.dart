import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../custom_widgets/nav_bar.dart';
import 'bloc/location_bloc.dart';
import 'details_tab.dart';
import 'experiences/experiences_tab.dart';

class LocationPage extends StatefulWidget {
  final String locationID;

  LocationPage({super.key, required this.locationID});

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
    BlocProvider.of<LocationBloc>(context)
        .add(RefreshLocationDetailsEvent(locationID: widget.locationID));
    BlocProvider.of<LocationBloc>(context)
        .add(RefreshLocationExperiencesEvent(locationID: widget.locationID));
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
    var location = {};
    var experiences = [];
    bool isFavorite = false;
    double expandedHeight = MediaQuery.of(context).size.height * 0.35;

    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        print('State is ${state}');
        //Controller listener
        _tabController.addListener(() {
          print('my index is' + _tabController.index.toString());
          print(experiences);
          if (_tabController.index == 1 && experiences.isEmpty) {
            BlocProvider.of<LocationBloc>(context).add(
                RefreshLocationExperiencesEvent(locationID: widget.locationID));
          }
        });
        if (state is LocationInitial) {
        } else if (state is GeneralErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('state.msg')),
          );
        } else if (state is RefreshDetailsState) {
          location = state.location;
        } else if (state is RefreshExperiencesState) {
          experiences = state.experiences;
        } else if (state is SuccessFavoriteAddState) {
          isFavorite = true;
        }
      },
      builder: (context, state) {
        if (state is LocationInitial) {
          print(state);
          return Scaffold(body: loadingView());
        } else {
          if (location.isEmpty) {
            BlocProvider.of<LocationBloc>(context).add(
                RefreshLocationDetailsEvent(locationID: widget.locationID));
            BlocProvider.of<LocationBloc>(context).add(
                RefreshLocationExperiencesEvent(locationID: widget.locationID));
            return Scaffold(body: loadingView());
          }
          return Scaffold(
            drawer: NavBar(),
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                      expandedHeight: expandedHeight,
                      floating: false,
                      pinned: true,
                      snap: false,
                      stretch: true,
                      centerTitle: true,
                      // TODO: Fading title
                      title: innerBoxIsScrolled
                          ? Text("${location['name'] ?? 'Place Name'}")
                          : Text(""),
                      flexibleSpace: FlexibleSpaceBar(
                        background: flexibleSpaceWidgetv2(
                            context,
                            expandedHeight,
                            location,
                            isFavorite), //flexibleSpaceWidget(context),

                        stretchModes: [
                          StretchMode.blurBackground,
                          StretchMode.zoomBackground
                        ],
                      ),
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      actions: [
                        IconButton(
                            onPressed: () {
                              // TODO: Navigate Write Experience Page
                            },
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
                      (state is LoadingDetailsState)
                          ? loadingView()
                          : LocationDetails(location: location),
                      (state is LoadingExperiencesState)
                          ? loadingView()
                          : LocationExperiences(experiences: experiences),
                      //TODO: Rethink Q&A widget
                      //Text("Q&A Tab"),
                    ],
                  ),
                ),
              ]),
            ),
          );
        }
      },
    );
  }

  Widget flexibleSpaceWidgetv2(BuildContext context, double expandedHeight,
      Map location, bool isFavorite) {
    return Container(
        height: expandedHeight + kToolbarHeight,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: (location['picture'] != null &&
                        !location['picture'].isEmpty)
                    ? NetworkImage('${location['picture']}')
                    : AssetImage('assets/images/mountain_sunset.jpg')
                        as ImageProvider,
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
                  Text('${location['name']}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 25)),
                  Text('${location['city']}, ${location['country']}',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        // TODO: Navigate to location page [location['mapLocation']]
                      },
                      icon: FaIcon(FontAwesomeIcons.locationDot,
                          color: Colors.white, size: 30)),
                  SizedBox(width: 20),
                  IconButton(
                      onPressed: () {
                        // TODO: Add to favorite places
                        if (!isFavorite) {
                          BlocProvider.of<LocationBloc>(context).add(
                              AddToFavoritesEvent(
                                  locationID: widget.locationID));
                        }
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: isFavorite
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        size: 30,
                      )),
                  SizedBox(width: 20),
                  IconButton(
                      onPressed: () {
                        // TODO: Navigate to Add to schedule page
                      },
                      icon: FaIcon(FontAwesomeIcons.calendarPlus,
                          color: Colors.white, size: 30)),
                ],
              )
            ],
          ),
        ));
  }

  Widget loadingView() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text('Loading'),
          ),
        ),
      ],
    );
  }
}
