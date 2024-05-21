import 'package:flutter/material.dart';

class ItemMenuWidget extends StatelessWidget {
  final String image;

  const ItemMenuWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth = constraints.maxWidth;
        double itemHeight = constraints.maxHeight;

        return Align(
          alignment: Alignment.center,
          child: Container(
            width: itemWidth,
            height: itemHeight,
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
