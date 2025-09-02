import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> assetImages = [
  'assets/images/image1.jpg',
  'assets/images/image2.jpg',
  'assets/images/image3.jpg',
  'assets/images/image4.jpg'
];

class GalleryCarousel extends StatelessWidget {
  const GalleryCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/gallery');
      },
      child: CarouselSlider(
        options: CarouselOptions(
          height: 400.0,
          autoPlay: true,
          enlargeCenterPage: false,
          viewportFraction: 0.95,
          pageSnapping: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          initialPage: 0,
          enableInfiniteScroll: true,
          pauseAutoPlayOnTouch: true,
        ),
        items: assetImages.map((imagePath) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
