import 'package:duan/widgets/test.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'item/item_bottom.dart';
import 'item/item_carousel_widget.dart';
import 'item/item_dangnhap.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget>{
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
    Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: 3,
      effect: ScrollingDotsEffect(
        dotWidth: 15,
        dotHeight: 15,
        activeDotColor: Colors.white,
      ),
    );

    return Center(
      child: Stack(
        children: [
          Carousel(
            onIndexChanged: (index) {
              setState(() {
                activeIndex = index; // Update activeIndex here
              });
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
            padding: const EdgeInsets.only(bottom: 30.0),
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
