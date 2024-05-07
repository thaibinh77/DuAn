import 'package:flutter/material.dart';

import 'item/item_menu.dart';

class FlipMenuWidget extends StatefulWidget {
  const FlipMenuWidget({Key? key}) : super(key: key);

  @override
  _FlipMenuWidgetState createState() => _FlipMenuWidgetState();
}

class _FlipMenuWidgetState extends State<FlipMenuWidget> {
  late int _startIndex = 0;
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> listCarousel = [
      ItemMenuWidget(
        image1: "assets/images/menu_1.png",
        image2: "assets/images/menu_2.png",
      ),
      ItemMenuWidget(
        image1: "assets/images/menu_3.png",
        image2: "assets/images/menu_4.png",
      ),
      ItemMenuWidget(
        image1: "assets/images/menu_5.png",
        image2: "assets/images/menu_6.png",
      ),
      ItemMenuWidget(
        image1: "assets/images/menu_7.png",
        image2: "assets/images/menu_8.png",
      ),
      ItemMenuWidget(
        image1: "assets/images/menu_9.png",
        image2: "assets/images/menu_10.png",
      ),
    ];

    return Center(

    );
  }
}