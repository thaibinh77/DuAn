import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:duan/widgets/item/item_carousel_widget.dart';
import '../../screens/menu_screen.dart';
import 'item/item_bottom.dart';
import 'item/item_dangnhap.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late int _startIndex = 0;

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
        // visible: _startIndex == 0,
      ),
      ItemCarouselWidget(
        img: "assets/images/banner2.png",
        // visible: _startIndex == 1,
      ),
      ItemCarouselWidget(
        img: "assets/images/banner3.png",
        // visible: _startIndex == 2,
      ),
      ItemCarouselWidget(
        img: "assets/images/banner4.png",
        // visible: _startIndex == 3,
      ),
      ItemCarouselWidget(
        img: "assets/images/banner5.png",
        // visible: _startIndex == 4,
      ),
      ItemCarouselWidget(
        img: "assets/images/banner6.png",
        // visible: _startIndex == 5,
      ),
    ];

    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: 2,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height, // Chiều cao gần bằng màn hình
            aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height, // Tỷ lệ khung hình fit với chiều dài và chiều ngang của màn hình
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.linear,
            onPageChanged: (index, reason) {
              setState(() {
                if (index == _startIndex + 1) {
                  _startIndex++;
                }
              });
            },
          ),
          itemBuilder: (BuildContext context, int index, _) {
            int itemIndex = _startIndex + index; // Tính toán vị trí trong danh sách carousel

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MenuScreen.routeName);
              },
              child: Stack(
                children: [
                  ...List.generate(listCarousel.length, (i) {
                    int currentIndex = itemIndex % listCarousel.length;
                    return Positioned(
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: i == currentIndex ? 1.0 : 0.0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: listCarousel[currentIndex],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: GestureDetector(
            onTap: () {
              _openLoginPage(context);
            },
            child: ItemBottom(),
          ),
        ),
      ],
    );
  }
}
