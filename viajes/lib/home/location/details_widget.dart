import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Place Name",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline6)),
            Divider(),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(width: 3),
                    Text("4.5"),
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
                SizedBox(width: 10),
                Row(
                  children: [
                    Icon(Icons.park),
                    SizedBox(width: 3),
                    Text("Place Type"),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
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
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec egestas ligula eget neque feugiat, non varius ipsum posuere. Cras lacinia luctus diam, nec sodales tellus aliquet non. Etiam tincidunt ex a est tincidunt sollicitudin. Pellentesque eget turpis nisl. Proin mollis vehicula placerat. Pellentesque aliquet scelerisque pulvinar. Maecenas et ex cursus, placerat eros a, viverra tellus. Etiam sodales porttitor efficitur. Suspendisse pellentesque dolor dictum lacus laoreet, a malesuada neque rutrum. Pellentesque nunc eros, viverra quis erat ac, vestibulum aliquam turpis. Aliquam tempor ultrices justo ac malesuada.",
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            Divider(),
            Align(
                alignment: Alignment.center,
                child: Text("Activities",
                    style: Theme.of(context).textTheme.headline6)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FaIcon(FontAwesomeIcons.personSwimming),
                FaIcon(FontAwesomeIcons.personHiking),
                FaIcon(FontAwesomeIcons.personWalking),
                FaIcon(FontAwesomeIcons.bowlFood),
                FaIcon(FontAwesomeIcons.tent)
              ],
            ),
            Divider(),
            SizedBox(height: 20),
            Divider(),
            Align(
                alignment: Alignment.center,
                child:
                    Text("Tags", style: Theme.of(context).textTheme.headline6)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FaIcon(FontAwesomeIcons.personSwimming),
                FaIcon(FontAwesomeIcons.personHiking),
                FaIcon(FontAwesomeIcons.personWalking),
                FaIcon(FontAwesomeIcons.bowlFood),
                FaIcon(FontAwesomeIcons.tent)
              ],
            ),
            Divider(),
          ],
        ));
  }
}
