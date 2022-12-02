import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viajes/custom_widgets/custom_icon_button.dart';
import 'package:viajes/custom_widgets/location_card.dart';
import 'package:viajes/custom_widgets/nav_bar.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  FocusNode searchFocus = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;
  bool isFocusSearch = false;
  var prevState = null;

  @override
  void initState() {
    super.initState();
    searchFocus.addListener(_onFocusChange);

    // Subscribe when keyboard on focus
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchFocus.removeListener(_onFocusChange);
    searchFocus.dispose();
  }

  void _onFocusChange() {
    isFocusSearch = searchFocus.hasFocus;

    debugPrint("Focus: ${searchFocus.hasFocus.toString()}");
  }

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
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
                    print('State: ${state}');
                    // if (keyboardChange) {
                    //   if (!isKeyboardVisible) {
                    //     FocusScope.of(context).unfocus();
                    //     BlocProvider.of<HomeBloc>(context)
                    //         .add(resetSearchEvent(prevState: prevState));
                    //   } else {
                    //     prevState = state;
                    //     BlocProvider.of<HomeBloc>(context)
                    //         .add(beginTypingEvent());
                    //   }
                    // }

                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return KeyboardVisibilityBuilder(
                        builder: (context, isKeyboardVisible) {
                      if (isKeyboardVisible) {
                        print('prevstate + ${prevState}');
                        print('state + ${state}');
                        if (!(prevState is isTypingState)) {
                          prevState = state;
                          BlocProvider.of<HomeBloc>(context)
                              .add(beginTypingEvent());
                        }

                        return Column(children: [
                          Center(
                            child: Text('Searching...'),
                          ),
                        ]);
                      } else {
                        if (prevState != null && state is isTypingState) {
                          print('158');
                          BlocProvider.of<HomeBloc>(context)
                              .add(resetSearchEvent(prevState: prevState));
                        }
                        if (state is ResultsState) {
                          return resultsView(context);
                        } else if (state is isTypingState) {
                          return Center();
                        } else {
                          return defaultView(context);
                        }
                      }
                    });
                  },
                ),
              )
            ]))
          ]),
        ));
  }

  Column resultsView(BuildContext context) {
    return Column(children: [
      Row(children: [
        IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              BlocProvider.of<HomeBloc>(context)
                  .add(resetSearchEvent(prevState: null));
            }),
        Expanded(child: Center(child: Text('Showing your search results')))
      ])
    ]);
  }

  Column defaultView(BuildContext context) {
    return Column(
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
            child:
                Text("Nearby", style: Theme.of(context).textTheme.headline6)),
        SizedBox(height: 20),
        Container(height: 170, child: _nearbyPlaces()),
        Align(
            alignment: Alignment.centerLeft,
            child:
                Text("Popular", style: Theme.of(context).textTheme.headline6)),
        SizedBox(height: 20),
        SizedBox(
            height: 160,
            child: LocationCard(
                width: 0.9,
                onTapCard: () {
                  // TODO: Send data to locationPage
                  Navigator.pushNamed(context, '/LocationPage');
                })),
      ],
    );
  }

  Widget _searchBar(BuildContext context) {
    return TextField(
      focusNode: searchFocus,
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
            icon: isFocusSearch ? Icon(Icons.close) : Icon(Icons.search),
            onPressed: () {
              print(isFocusSearch);
              if (isFocusSearch) {
                FocusScope.of(context).requestFocus(null);
                searchController.clear();
              }
              searchFocus.requestFocus();
              setState(() {});

              //TODO: Search
              BlocProvider.of<HomeBloc>(context)
                  .add(searchEvent(searchString: searchController.text));
            }),
        suffixIcon: IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              // TODO: Filter/sort actions
            }),
      ),
      onSubmitted: (value) {
        // TODO: Search
        BlocProvider.of<HomeBloc>(context)
            .add(searchEvent(searchString: searchController.text));
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
          iconID: 61668,
          iconFamily: 'FontAwesomeSolid',
          buttonSize: 60,
          iconColor: Theme.of(context).iconTheme.color,
          buttonColor: Colors.amberAccent[100],
          onButtonPressed: () {
            //TODO: Filter search
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
              child: LocationCard(
                  width: 0.4,
                  onTapCard: () {
                    // TODO: Send data to LocationPage
                    Navigator.pushNamed(context, '/LocationPage');
                  }));
        });
  }
}
