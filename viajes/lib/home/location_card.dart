import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final double width;
  final VoidCallback? onTapCard;
  const LocationCard({super.key, required this.width, this.onTapCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Material(
              color: Theme.of(context).primaryColor,
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                  onTap: () {
                    print(onTapCard);
                    onTapCard != null ? onTapCard!() : null;
                  },
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Stack(children: <Widget>[
                      Ink.image(
                          image:
                              AssetImage("assets/images/mountain_sunset.jpg"),
                          height: 90,
                          width: MediaQuery.of(context).size.width * width,
                          fit: BoxFit.cover),
                    ]),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 3, right: 3),
                      child: Column(
                        children: [
                          Text("Place Name", overflow: TextOverflow.fade),
                          SizedBox(height: 3),
                          Text("10km away",
                              overflow: TextOverflow.fade,
                              style: Theme.of(context).textTheme.bodySmall)
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ]))),
        ],
      ),
    );
  }
}
