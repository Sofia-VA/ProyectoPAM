import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:viajes/home/location/custom_label_list.dart';

class LocationDetails extends StatefulWidget {
  const LocationDetails({super.key});

  @override
  State<LocationDetails> createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  final activities = [
    {'name': 'Swim', 'iconID': 0xf5c4, 'iconFamily': 'FontAwesomeSolid'},
    {'name': 'Hike', 'iconID': 0xf6ec, 'iconFamily': 'FontAwesomeSolid'},
    {'name': 'Walk', 'iconID': 0xf554, 'iconFamily': 'FontAwesomeSolid'},
    {'name': 'Eat', 'iconID': 0xe4c6, 'iconFamily': 'FontAwesomeSolid'},
    {'name': 'Camp', 'iconID': 0xe582, 'iconFamily': 'FontAwesomeSolid'},
    {'name': 'Run', 'iconID': 0xf70c, 'iconFamily': 'FontAwesomeSolid'},
    {'name': 'Sightsee', 'iconID': 0xf520, 'iconFamily': 'FontAwesomeSolid'},
    {'name': 'Sleep', 'iconID': 0xf236, 'iconFamily': 'FontAwesomeSolid'},
  ];
  final tags = [
    'fun',
    'peaceful',
    'long wait line',
    'nature',
    'quiet',
    'wild danger',
    'expensive tickets',
    'far from locals',
    'very hot'
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                _placeHeader(context),
                SizedBox(height: 20),
                _generalInfo(context),
                SizedBox(height: 20),
                _generalInfoIcons(),
                SizedBox(height: 20),
                _activitiesIcons(activities),
                SizedBox(height: 20),
                _placeTags(context, tags),
              ],
            ))
      ]))
    ]);
  }

  Widget _placeHeader(context) {
    return Column(children: [
      Divider(),
      Align(
          alignment: Alignment.center,
          child: Text("Place Name",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline6)),
      Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.amberAccent),
              SizedBox(width: 3),
              Text("4.5"),
            ],
          ),
          SizedBox(width: 10),
          Row(
            children: [
              Icon(Icons.park),
              SizedBox(width: 3),
              Text("Place Type"),
            ],
          ),
          SizedBox(width: 10),
          Row(
            children: [
              Icon(Icons.favorite),
              SizedBox(width: 3),
              Text("312"),
            ],
          ),
        ],
      ),
    ]);
  }

  Widget _generalInfo(BuildContext context) {
    return Column(children: [
      Divider(),
      Align(
          alignment: Alignment.center,
          child: Text("General Information",
              style: Theme.of(context).textTheme.headline6)),
      Divider(),
      Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            //color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ReadMoreText(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec egestas ligula eget neque feugiat, non varius ipsum posuere. Cras lacinia luctus diam, nec sodales tellus aliquet non. Etiam tincidunt ex a est tincidunt sollicitudin. Pellentesque eget turpis nisl. Proin mollis vehicula placerat. Pellentesque aliquet scelerisque pulvinar. Maecenas et ex cursus, placerat eros a, viverra tellus. Etiam sodales porttitor efficitur. Suspendisse pellentesque dolor dictum lacus laoreet, a malesuada neque rutrum. Pellentesque nunc eros, viverra quis erat ac, vestibulum aliquam turpis. Aliquam tempor ultrices justo ac malesuada.",
          trimLines: 4,
          trimMode: TrimMode.Line,
          moreStyle: TextStyle(color: Theme.of(context).primaryColor),
          lessStyle: TextStyle(color: Theme.of(context).primaryColor),
          trimCollapsedText: 'Show more',
          trimExpandedText: 'Show less',
          textAlign: TextAlign.justify,
        ),
      ),
    ]);
  }

  Widget _generalInfoIcons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(Icons.monetization_on),
                SizedBox(width: 3),
                Text("210 USD"),
              ],
            ),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.cloudRain, size: 19),
                SizedBox(width: 5),
                Text("Rainy"),
              ],
            ),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.peopleLine, size: 19),
                SizedBox(width: 5),
                Text("2k+ daily"),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                FaIcon(FontAwesomeIcons.clock),
                SizedBox(width: 5),
                Text("Open Now"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _activitiesIcons(List activities) {
    return Column(children: [
      Divider(),
      Align(
          alignment: Alignment.center,
          child:
              Text("Activities", style: Theme.of(context).textTheme.headline6)),
      Divider(),
      SizedBox(height: 20),
      CustomLabelList(
          labelList: activities,
          hasTooltip: true,
          hasIcon: true,
          hasText: false),
    ]);
  }
}

Widget _placeTags(BuildContext context, List tags) {
  return Column(children: [
    Divider(),
    Align(
        alignment: Alignment.center,
        child: Text("Tags", style: Theme.of(context).textTheme.headline6)),
    Divider(),
    SizedBox(height: 20),
    CustomLabelList(
        listSpacing: 5,
        labelList: tags,
        hasIcon: false,
        labelColor: Theme.of(context).primaryColor),
  ]);
}
