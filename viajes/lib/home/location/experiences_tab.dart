import 'dart:math';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'package:flutter/material.dart';

class LocationExperiences extends StatelessWidget {
  const LocationExperiences({super.key});

  @override
  Widget build(BuildContext context) {
    final assetImages = const [
      'assets/images/mountain_sunset.jpg',
      'assets/images/mountain_night.gif',
      'assets/images/lake_morning.png',
    ];
    final List _experiencesList = [
      {
        'title': 'The worst trip in my life',
        'author': 'AuthorUserName',
        'images': ['', ''],
        'likes': 12
      },
      {
        'title': 'I love this place!',
        'author': 'AuthorUserName2',
        'images': [],
        'likes': 3
      },
      {
        'title': 'A great place to spend some quiet time',
        'author': 'AuthorUserName334',
        'images': [''],
        'likes': 122
      },
      {
        'title': 'This year was not as good as the last one',
        'author': 'ShortUsername',
        'images': [''],
        'likes': 122
      },
      {
        'title': 'I can guide you if you\'d like!',
        'author': 'EpicTraveler',
        'images': [],
        'likes': 1000
      },
      {
        'title': 'Pretty cool!',
        'author': 'AuthorUserName334',
        'images': [],
        'likes': 34
      },
      {
        'title': 'A great place to spend some quiet time',
        'author': 'AuthorUserName334',
        'images': [''],
        'likes': 122
      }
    ];
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            children: [
              WaterfallFlow.builder(
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 0),
                itemCount: _experiencesList.length,
                gridDelegate: SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
                  viewportBuilder: (int firstIndex, int lastIndex) {
                    print("viewport : [$firstIndex,$lastIndex]");
                  },
                  maxCrossAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  bool hasImage = _experiencesList[index]['images'].length > 0
                      ? true
                      : false;
                  return Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(children: [
                            (hasImage)
                                ? (_experiencesList[index]['images'][0] !=
                                            null &&
                                        !_experiencesList[index]['images'][0]
                                            .isEmpty
                                    ? Image.network(
                                        _experiencesList[index]['images'][0],
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(assetImages[
                                        Random().nextInt(assetImages.length)]))
                                : Center(),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              color:
                                  Colors.teal[Random().nextInt(3) * 100 + 100],
                              child: Text(_experiencesList[index]['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                          ]),
                          shape: hasImage
                              ? RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                              : null,
                          elevation: 5,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child:
                              _cardSubtitle(context, _experiencesList[index]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          )
          // (context, index) {

          //   },
        ])),
      ],
    );
  }

  _cardSubtitle(BuildContext context, Map experience) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text('by ${experience['author']}',
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.bodySmall)),
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          child: DefaultTextStyle.merge(
              style: Theme.of(context).textTheme.bodySmall,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.favorite, size: 10),
                  Text('  '),
                  Text(
                      '${experience['likes'] >= 1000 ? '1k+' : experience['likes']}'),
                  Text('   '),
                ],
              )),
        ),
      ],
    );
  }
}
