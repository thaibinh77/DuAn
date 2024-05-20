import 'dart:math';

import 'package:flutter/material.dart';
import 'item/item_menu.dart';

class FlipMenuWidget extends StatefulWidget {
  const FlipMenuWidget({Key? key}) : super(key: key);

  @override
  _FlipMenuWidgetState createState() => _FlipMenuWidgetState();
}

class _FlipMenuWidgetState extends State<FlipMenuWidget> with TickerProviderStateMixin {
  late List<AnimationController> controllers;
  int currentControllerIndex = 0;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (index) => AnimationController(vsync: this, duration: const Duration(seconds: 1)));
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void handleButtonPressForward() {
    if (currentControllerIndex < controllers.length) {
      controllers[currentControllerIndex].forward();
      currentControllerIndex++;
    }
  }

  void handleButtonPressReverse() {
    if (currentControllerIndex > 0) {
      currentControllerIndex--;
      controllers[currentControllerIndex].reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ItemMenuWidget> listCarousel = [
      ItemMenuWidget(
        image1: "assets/images/menu_2.png",
        image2: "assets/images/menu_3.png",
        controller: controllers[0],
      ),
      ItemMenuWidget(
        image1: "assets/images/menu_4.png",
        image2: "assets/images/menu_5.png",
        controller: controllers[1],
      ),
      ItemMenuWidget(
        image1: "assets/images/menu_6.png",
        image2: "assets/images/menu_7.png",
        controller: controllers[2],
      ),
      ItemMenuWidget(
        image1: "assets/images/menu_8.png",
        image2: "assets/images/menu_9.png",
        controller: controllers[3],
      ),
    ];

    List<Widget> stackedItems = [];

    for (var i = 0; i < listCarousel.length; i++) {
      stackedItems.add(
        Container(
          width: 290,
          height: 300,
          child: listCarousel[i],
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 290,
              height: 300,
              child: Image.asset("assets/images/menu_1.png", fit: BoxFit.cover),
            ),
            Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    width: 290,
                    height: 300,
                    child: Image.asset("assets/images/menu_2.png", fit: BoxFit.cover),
                  ),
                  if (currentControllerIndex == 0) ...stackedItems.reversed.toList(),
                ]
            ),
          ],
        ),
        CustomButton(
          forward: handleButtonPressForward,
          reverse: handleButtonPressReverse,
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback? forward;
  final VoidCallback? reverse;

  const CustomButton({
    Key? key,
    this.forward,
    this.reverse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: reverse,
          child: Text('Reverse'),
        ),
        ElevatedButton(
          onPressed: forward,
          child: Text('Forward'),
        ),
      ],
    );
  }
}
