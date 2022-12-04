import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_shadow/flutter_icon_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../custom_widgets/comments/comment_section.dart';
import '../../custom_widgets/nav_bar.dart';
import '../../custom_widgets/image_carousel_widget.dart';
import '../location_page.dart';
import 'bloc/experience_bloc.dart';

class ExperiencePage extends StatefulWidget {
  final String experienceID;

  ExperiencePage({super.key, required this.experienceID});

  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  final commentSectionAnchor = GlobalKey();

  final galleryImages = const [
    'assets/images/mountain_sunset.jpg',
    'assets/images/mountain_night.gif',
    'assets/images/lake_morning.png',
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExperienceBloc>(context)
        .add(RefreshExperienceEvent(experienceID: widget.experienceID));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLiked = false;
    var experience = {};

    return BlocConsumer<ExperienceBloc, ExperienceState>(
      listener: (context, state) {
        print('State is ${state}');
        if (state is ExperienceInitial) {
          BlocProvider.of<ExperienceBloc>(context)
              .add(RefreshExperienceEvent(experienceID: widget.experienceID));
        } else if (state is GeneralErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('state.msg')),
          );
        } else if (state is RefreshExperienceState) {
          experience = state.experience;
          isLiked = state.isLiked;
        } else if (state is SuccessLikingState) {
          isLiked = true;
        }
      },
      builder: (context, state) {
        if (state is ExperienceInitial || state is LoadingExperienceState) {
          return Scaffold(body: loadingView());
        } else {
          if (experience.isEmpty) {
            BlocProvider.of<ExperienceBloc>(context)
                .add(RefreshExperienceEvent(experienceID: widget.experienceID));
            return Scaffold(body: loadingView());
          }
          return _defaultView(experience, isLiked);
        }
      },
    );
  }

  Row _experienceTitle(BuildContext context, Map experience) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Text(experience['title'] ?? "Experience Post Title",
                style: Theme.of(context).textTheme.headline5)),
        Row(
          children: [
            Icon(Icons.star, size: 25, color: Colors.amberAccent),
            SizedBox(width: 3),
            Text('${experience['rating']}',
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }

  Widget _postData(BuildContext context, Map experience) {
    return Row(children: [
      Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.date_range, size: 25),
            SizedBox(width: 3),
            Text('${experience['formatDate']}'),
          ],
        ),
      ),
      Flexible(
        child: ListTile(
            title: Text("by ${experience['authorInfo']?['name'] ?? 'Username'}",
                textAlign: TextAlign.end),
            trailing: CircleAvatar(
                radius: 18,
                child: experience['authorInfo']?['profilePicture'] != null &&
                        experience['authorInfo']?['profilePicture'] != ''
                    ? ClipOval(
                        child: Image.network(
                            experience['authorInfo']?['profilePicture']))
                    : Icon(Icons.person),
                backgroundColor: Theme.of(context).listTileTheme.iconColor),
            onTap: () {
              // TODO: Send to ProfilePage
              // Navigator.pop(context);
            }),
      ),
    ]);
  }

  Row _postHeader(BuildContext context, commentSectionAnchor, Map experience) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: ListTile(
            leading: IconButton(
                onPressed: () {
                  BlocProvider.of<ExperienceBloc>(context)
                      .add(ResetStateEvent());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          LocationPage(locationID: experience['locationID'])));
                },
                icon: FaIcon(FontAwesomeIcons.locationDot, size: 25)),
            title: Transform.translate(
              offset: Offset(-16, 0),
              child: Text(experience['placeInfo']['placeName'] ?? "Place Name",
                  style: Theme.of(context).textTheme.labelLarge),
            ),
            subtitle: Transform.translate(
              offset: Offset(-16, 0),
              child: Text(
                "${experience['placeInfo']['placeCity'] ?? 'City'}, ${experience['placeInfo']['placeCountry'] ?? 'Country'}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        Row(
          children: [
            Icon(Icons.monetization_on, size: 25),
            SizedBox(width: 3),
            Text('${experience['price']}',
                style: Theme.of(context).textTheme.bodyLarge),
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

  Widget _defaultView(Map experience, bool isLiked) {
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
                onPressed: () {
                  // TODO: Like experience | Test
                  BlocProvider.of<ExperienceBloc>(context).add(
                      LikeExperienceEvent(experienceID: widget.experienceID));
                },
                icon: IconShadow(
                  Icon(Icons.favorite,
                      color: isLiked ? Theme.of(context).primaryColor : null),
                  shadowOffset: Offset.fromDirection(1, 2),
                  shadowColor: Color.fromARGB(114, 0, 0, 0),
                  shadowBlurSigma: 1,
                )),
          ]),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            (!experience['images'].isEmpty) ? SizedBox(height: 20) : Center(),
            (!experience['images'].isEmpty)
                ? ImageCarousel(galleryImages: experience['images'])
                : Center(),
            (!experience['images'].isEmpty) ? SizedBox(height: 20) : Center(),
            Container(
                padding: EdgeInsets.fromLTRB(22, 22, 22, 0),
                child: Column(
                  children: [
                    _experienceTitle(context, experience),
                    SizedBox(height: 5),
                    Divider(thickness: 2),
                    _postData(context, experience),
                    Divider(thickness: 2),
                    _postHeader(context, commentSectionAnchor, experience),
                    Divider(thickness: 2),
                    SizedBox(height: 20),
                    Text(
                      experience['description'],
                      textAlign: TextAlign.justify,
                    ),
                  ],
                )),
            CommentSection(
              anchor: commentSectionAnchor,
              parentID: widget.experienceID,
            )
          ],
        ),
      ),
    );
  }
}
