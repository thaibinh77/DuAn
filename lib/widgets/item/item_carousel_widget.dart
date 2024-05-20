import 'package:flutter/material.dart';
import 'package:duan/resources/app_color.dart';
import '../flip_menu_widget.dart';
import 'item_bottom.dart';
import 'item_dangnhap.dart';

class ItemCarouselWidget extends StatelessWidget {
  const ItemCarouselWidget({
    Key? key,
    required this.img,
  }) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FlipMenuWidget()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width + 70,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
