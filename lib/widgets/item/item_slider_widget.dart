import 'package:flutter/material.dart';
import '../../screens/menu_screen.dart';

class ItemSliderWidget extends StatelessWidget {
  const ItemSliderWidget({
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
          MaterialPageRoute(builder: (context) => MenuScreen()),
        );
      },
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
    );
  }
}
