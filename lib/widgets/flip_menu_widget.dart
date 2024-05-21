import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/item/item_test.dart';
import 'carousel_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late List<AnimationController> controllers;
  int currentControllerIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(5, (index) => AnimationController(vsync: this, duration: const Duration(seconds: 10)));

    // Khởi tạo và bắt đầu đếm ngược
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Hủy Timer khi widget được dispose

    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: 15), () {
      // Nếu đếm ngược kết thúc mà không có tương tác từ người dùng,
      // thì tự động chuyển đến trang slideshow
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CarouselWidget()),
      );    });
  }

  void _resetTimer() {
    // Hủy timer hiện tại và bắt đầu lại đếm ngược
    _timer.cancel();
    _startTimer();
  }

  void handleButtonPressForward() {
    if (currentControllerIndex < controllers.length - 1) {
      setState(() {
        currentControllerIndex++;
      });
      controllers[currentControllerIndex].forward();
      _resetTimer();
    }
  }

  void handleButtonPressReverse() {
    if (currentControllerIndex > 0) {
      setState(() {
        currentControllerIndex--;
      });
      controllers[currentControllerIndex].reverse();
      _resetTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ItemTestWidget> listCarousel = [
      ItemTestWidget(
        image1: "assets/images/menu_1.png",
        image2: "assets/images/menu_2.png",
        image3: "assets/images/menu_3.png",
        // onPressed1: handleButtonPressReverse,
        onPressed2: handleButtonPressForward,
      ),
      ItemTestWidget(
        image1: "assets/images/menu_3.png",
        image2: "assets/images/menu_4.png",
        image3: "assets/images/menu_5.png",
        onPressed1: handleButtonPressReverse,
        onPressed2: handleButtonPressForward,
      ),
      ItemTestWidget(
        image1: "assets/images/menu_5.png",
        image2: "assets/images/menu_6.png",
        image3: "assets/images/menu_7.png",
        onPressed1: handleButtonPressReverse,
        onPressed2: handleButtonPressForward,
      ),
      ItemTestWidget(
        image1: "assets/images/menu_7.png",
        image2: "assets/images/menu_8.png",
        image3: "assets/images/menu_9.png",
        onPressed1: handleButtonPressReverse,
        onPressed2: handleButtonPressForward,
      ),
      ItemTestWidget(
        image1: "assets/images/menu_9.png",
        image2: "assets/images/menu_10.png",
        image3: "assets/images/menu_10.png",
        onPressed1: handleButtonPressReverse,
        // onPressed2: handleButtonPressForward,
      ),
    ];

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: IndexedStack(
                    index: currentControllerIndex,
                    children: listCarousel,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}