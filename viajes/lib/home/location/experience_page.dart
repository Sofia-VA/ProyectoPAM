import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_shadow/flutter_icon_shadow.dart';

import 'package:swipe_image_gallery/swipe_image_gallery.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final galleryImages = const [
    Image(image: AssetImage('assets/images/mountain_sunset.jpg')),
    Image(image: AssetImage('assets/images/mountain_night.gif')),
    Image(image: AssetImage('assets/images/lake_morning.png')),
  ];

  StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();

  @override
  void dispose() {
    overlayController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: IconShadow(
                Icon(Icons.arrow_back_ios),
                shadowOffset: Offset.fromDirection(1, 2),
                shadowColor: Color.fromARGB(114, 0, 0, 0),
                shadowBlurSigma: 1,
              ),
              onPressed: () {
                //Navigator.pop(context);
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
        child: Column(
          children: [SizedBox(height: 20), imageCarousel(context)],
        ),
      ),
    );
  }

  Widget imageCarousel(BuildContext context) {
    return Container(
        child: CarouselSlider.builder(
            itemCount: galleryImages.length,
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1.0,
              height: MediaQuery.of(context).size.height * 0.3,
              enlargeCenterPage: true,
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    GestureDetector(
                        onTap: () {
                          SwipeImageGallery(
                            context: context,
                            children: galleryImages,
                            initialIndex: itemIndex,
                            onSwipe: (index) {
                              overlayController.add(GalleryOverlay(
                                title: '${index + 1}/${galleryImages.length}',
                              ));
                            },
                            overlayController: overlayController,
                            initialOverlay: GalleryOverlay(
                              title: '${itemIndex + 1}/${galleryImages.length}',
                            ),
                          ).show();
                        },
                        child: galleryImages[itemIndex])));
  }
}

Widget experienceBody(BuildContext context) {
  return Container();
}

class GalleryOverlay extends StatelessWidget {
  const GalleryOverlay({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 19.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ]),
              ),
            ),
            IconButton(
              icon: IconShadow(
                Icon(Icons.close),
                shadowOffset: Offset.fromDirection(1, 2),
                shadowColor: Color.fromARGB(114, 0, 0, 0),
                shadowBlurSigma: 1,
              ),
              color: Colors.white,
              tooltip: 'Close',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
