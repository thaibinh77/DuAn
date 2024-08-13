import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../widgets/item/item_test.dart';
import 'item/item_menu.dart';
import 'slider_widget.dart';

class CarouselMenuWidget extends StatefulWidget {
  const CarouselMenuWidget({Key? key}) : super(key: key);

  @override
  _CarouselMenuState createState() => _CarouselMenuState();
}

class _CarouselMenuState extends State<CarouselMenuWidget> with TickerProviderStateMixin {
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
        MaterialPageRoute(builder: (context) => SliderWidget()),
      );
    });
  }

  void _resetTimer() {
    // Hủy timer hiện tại và bắt đầu lại đếm ngược
    _timer.cancel();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    List<ItemMenuWidget> listCarousel = [
      ItemMenuWidget(
        image: "assets/images/menu_1.png",
      ),
      ItemMenuWidget(
        image: "assets/images/menu_2.png",
      ),
      ItemMenuWidget(
        image: "assets/images/menu_3.png",
      ),
      ItemMenuWidget(
        image: "assets/images/menu_4.png",
      ),
      ItemMenuWidget(
        image: "assets/images/menu_5.png",
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height, // Điều chỉnh chiều cao của các item
            aspectRatio: 1.0,
            autoPlay: false, // Tự động lướt
            enlargeCenterPage: true, // Phóng to mục ở giữa
            viewportFraction: 1.0, // Điều chỉnh kích thước của các item
            enlargeStrategy: CenterPageEnlargeStrategy.height, // Phóng to item theo chiều cao
            scrollPhysics: BouncingScrollPhysics(), // Sử dụng scroll physics với hiệu ứng rebound
            scrollDirection: Axis.horizontal, // Hướng cuộn của carousel
            // Giảm duration để tăng tốc độ trượt
            autoPlayAnimationDuration: const Duration(
                milliseconds: 100), // Thời gian chuyển đổi giữa các lượt lướt
            onPageChanged: (index, reason) {
              _resetTimer(); // Reset timer mỗi khi trang thay đổi
            },
          ),
          items: listCarousel.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width, // Độ rộng của mỗi mục
                  margin: EdgeInsets.symmetric(horizontal: 30.0), // Khoảng cách giữa các mục
                  child: item,
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
