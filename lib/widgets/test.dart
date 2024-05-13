import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'flip_menu_widget.dart';
import 'item/item_dangnhap.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late int _startIndex = 0;
  int activeIndex = 0;

  void _openLoginPage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoginDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listCarousel = [
      ItemCarouselWidget(
        img: "assets/images/banner1.png",
        visible: _startIndex == 0,
      ),
      ItemCarouselWidget(
        img: "assets/images/banner2.png",
        visible: _startIndex == 1,
      ),
      ItemCarouselWidget(
        img: "assets/images/banner3.png",
        visible: _startIndex == 2,
      ),
    ];

    Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: listCarousel.length,
      effect: ScrollingDotsEffect(
        dotWidth: 15,
        dotHeight: 15,
        activeDotColor: Colors.white,
      ),
    );

    return Center(
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: listCarousel.length,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height, // Chiều cao gần bằng màn hình
              aspectRatio: MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height, // Tỷ lệ khung hình fit với chiều dài và chiều ngang của màn hình
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.linear,
              onPageChanged: (index, reason) {
                setState(() {
                  _startIndex = index;
                  activeIndex = index;
                });
              },
            ),
            itemBuilder: (BuildContext context, int index, _) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0), // Khoảng cách giữa các item
                child: Stack(
                  children: [
                    listCarousel[index],
                  ],
                ),
              );
            },
          ),
          Positioned(
            right: 50,
            bottom: 40,
            child: GestureDetector(
              onTap: () {
                _openLoginPage(context);
              },
              child: ItemBottom(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0), // Khoảng cách từ dưới lên
            child: Align(
              alignment: Alignment.bottomCenter,
              child: buildIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCarouselWidget extends StatelessWidget {
  const ItemCarouselWidget({
    Key? key,
    required this.img,
    required this.visible,
  }) : super(key: key);

  final String img;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FlipMenuWidget()),
        );
      },
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: visible ? 1.0 : 0.0,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: 80,
      height: 80,
    );
  }
}
