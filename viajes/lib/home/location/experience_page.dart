import 'package:flutter/material.dart';
import 'package:flutter_icon_shadow/flutter_icon_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:viajes/home/location/comments/comment_section.dart';

import '../../nav_bar.dart';
import 'image_carousel_widget.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  ScrollController scrollController = ScrollController();

  final commentSectionAnchor = GlobalKey();

  final galleryImages = const [
    'assets/images/mountain_sunset.jpg',
    'assets/images/mountain_night.gif',
    'assets/images/lake_morning.png',
  ];

  final description =
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam gravida tortor ante, a blandit libero lobortis ut. Mauris vehicula tortor ut ex ultricies sodales. Proin ultrices eleifend diam eget congue. Sed iaculis aliquet diam, ac tempus enim. Maecenas scelerisque sodales massa in lacinia. Proin porta mi diam, eu interdum nibh elementum a. Proin vestibulum libero justo, a tincidunt urna vehicula in. Nam vitae mauris diam. Nam in lacinia arcu, vitae consectetur lacus. Quisque et odio lacus. Suspendisse ligula elit, mattis sit amet venenatis placerat, luctus non enim.

Integer ac fermentum neque. Aenean ipsum metus, cursus sed nisl quis, fermentum sagittis elit. Aliquam pulvinar sapien vitae ligula auctor blandit. Fusce vel tristique lorem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Quisque at nibh nunc. Interdum et malesuada fames ac ante ipsum primis in faucibus. Donec suscipit risus erat, dapibus pretium enim vestibulum in. Sed sed lorem non est pretium mollis non eget velit. Donec fermentum pretium lectus quis suscipit. Sed eu elit efficitur diam convallis tincidunt. Nullam consequat vehicula nisi, ut euismod lacus interdum vitae. Curabitur ornare felis et dui mollis rhoncus. Sed eu felis mi. Morbi eros lorem, consequat eget tincidunt eu, imperdiet a est.

Integer eget neque tortor. Morbi ligula leo, suscipit et ligula in, molestie dignissim est. Phasellus metus enim, condimentum at consequat vitae, ultrices sed tellus. Donec vel luctus ante, a pellentesque tortor. Donec ligula velit, consectetur in metus sit amet, sollicitudin ultricies nibh. Maecenas aliquam pharetra nisi. Curabitur feugiat vulputate finibus. Sed arcu eros, rhoncus vitae purus et, aliquet tincidunt mauris. Duis iaculis lacinia neque in tempus. Suspendisse gravida rhoncus nisl vel fermentum. Praesent eu nibh dolor.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
          leading: IconButton(
              icon: IconShadow(
                Icon(Icons.arrow_back_ios),
                shadowOffset: Offset.fromDirection(1, 2),
                shadowColor: Color.fromARGB(114, 0, 0, 0),
                shadowBlurSigma: 1,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
                onPressed: () {},
                icon: IconShadow(
                  Icon(Icons.favorite),
                  shadowOffset: Offset.fromDirection(1, 2),
                  shadowColor: Color.fromARGB(114, 0, 0, 0),
                  shadowBlurSigma: 1,
                )),
          ]),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(height: 20),
            ImageCarousel(galleryImages: galleryImages),
            SizedBox(height: 20),
            Container(
                padding: EdgeInsets.fromLTRB(22, 22, 22, 0),
                child: Column(
                  children: [
                    _experienceTitle(context),
                    SizedBox(height: 5),
                    Divider(thickness: 2),
                    _postData(context),
                    Divider(thickness: 2),
                    _postHeader(context, commentSectionAnchor),
                    Divider(thickness: 2),
                    SizedBox(height: 20),
                    Text(
                      description,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                )),
            CommentSection(anchor: commentSectionAnchor)
          ],
        ),
      ),
    );
  }

  Row _experienceTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Text("Experience Post Title",
                style: Theme.of(context).textTheme.headline5)),
        Row(
          children: [
            Icon(Icons.star, size: 25, color: Colors.amberAccent),
            SizedBox(width: 3),
            Text('4.5', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }

  Widget _postData(BuildContext context) {
    return Row(children: [
      Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.date_range, size: 25),
            SizedBox(width: 3),
            Text('12/11/2022'),
          ],
        ),
      ),
      Flexible(
        child: ListTile(
            title: Text("by Long Username Name", textAlign: TextAlign.end),
            trailing: CircleAvatar(
                radius: 18,
                child: Icon(Icons.person),
                backgroundColor: Theme.of(context).listTileTheme.iconColor),
            onTap: () {
              // TODO: Send to ProfilePage
              // Navigator.pop(context);
            }),
      ),
    ]);
  }

  Row _postHeader(BuildContext context, commentSectionAnchor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: ListTile(
            leading: IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.locationDot, size: 25)),
            title: Transform.translate(
              offset: Offset(-16, 0),
              child: Text("Place Name",
                  style: Theme.of(context).textTheme.labelLarge),
            ),
            subtitle: Transform.translate(
              offset: Offset(-16, 0),
              child: Text(
                "City, Country",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        Row(
          children: [
            Icon(Icons.monetization_on, size: 25),
            SizedBox(width: 3),
            Text('Free', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        IconButton(
            onPressed: () {
              if (commentSectionAnchor.currentContext != null) {
                Scrollable.ensureVisible(
                  commentSectionAnchor.currentContext,
                  alignment: 0.5,
                  duration: const Duration(seconds: 1),
                );
              }
            },
            icon: Icon(Icons.comment_rounded)),
        SizedBox(width: 20)
      ],
    );
  }
}
