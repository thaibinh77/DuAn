import 'package:duan/providers/banner_provider.dart';
import 'package:duan/widgets/test.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'item/item_bottom.dart';
import 'item/item_dangnhap.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget>{
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
    final screenHeight = MediaQuery.of(context).size.height;

    Widget buildIndicator() {
      // Tính toán dotWeight và dotHeight tùy thuộc vào kích thước màn hình
      final dotHeight = screenHeight * 0.02;

      return AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: listCarousel.length,
        effect: ScrollingDotsEffect(
          dotWidth: dotHeight,
          dotHeight: dotHeight,
          activeDotColor: Colors.white,
        ),
      );
    }

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
