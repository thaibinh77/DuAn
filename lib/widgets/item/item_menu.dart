import 'package:flutter/material.dart';

class ItemMenuWidget extends StatelessWidget {
  final String image1;
  final String image2;

  const ItemMenuWidget({
    Key? key,
    required this.image1,
    required this.image2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Image.asset(
            image1,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Image.asset(
            image2,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}