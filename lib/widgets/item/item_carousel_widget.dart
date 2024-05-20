import 'package:flutter/material.dart';
import 'package:duan/resources/app_color.dart';
import '../flip_menu_widget.dart';
import 'item_bottom.dart';
import 'item_dangnhap.dart';

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
