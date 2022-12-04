import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_shadow/flutter_icon_shadow.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

class ImageCarousel extends StatefulWidget {
  final galleryImages;
  const ImageCarousel({super.key, required this.galleryImages});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

// TODO: Handle a single, 2, and null images

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    StreamController<Widget> overlayController =
        StreamController<Widget>.broadcast();

    @override
    void dispose() {
      overlayController.close();
      super.dispose();
    }

    if (widget.galleryImages.length == 0) {
      return Center();
    } else if (widget.galleryImages.length == 1) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(10),
          child: GestureDetector(
              onTap: () {
                SwipeImageGallery(
                  context: context,
                  children: widget.galleryImages
                      .map<Widget>((img) => Image(image: NetworkImage(img)))
                      .toList(),
                  initialIndex: 1,
                  onSwipe: (index) {
                    overlayController.add(GalleryOverlay(
                      title: '1/1',
                    ));
                  },
                  overlayController: overlayController,
                  initialOverlay: GalleryOverlay(
                    title: '1/1',
                  ),
                ).show();
              },
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(widget.galleryImages[0]),
                          fit: BoxFit.cover)))));
    } else {
      return Container(
          child: CarouselSlider.builder(
              itemCount: widget.galleryImages.length,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1.0,
                height: MediaQuery.of(context).size.height * 0.3,
                enlargeCenterPage: true,
                viewportFraction: 0.7,
              ),
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return GestureDetector(
                    onTap: () {
                      SwipeImageGallery(
                        context: context,
                        children: widget.galleryImages
                            .map<Widget>(
                                (img) => Image(image: NetworkImage(img)))
                            .toList(),
                        initialIndex: itemIndex,
                        onSwipe: (index) {
                          overlayController.add(GalleryOverlay(
                            title:
                                '${index + 1}/${widget.galleryImages.length}',
                          ));
                        },
                        overlayController: overlayController,
                        initialOverlay: GalleryOverlay(
                          title:
                              '${itemIndex + 1}/${widget.galleryImages.length}',
                        ),
                      ).show();
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.galleryImages[itemIndex]),
                                fit: BoxFit.cover))));
              }));
    }
  }
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
