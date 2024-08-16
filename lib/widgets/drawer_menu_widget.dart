import 'package:flutter/material.dart';

import '../models/image.dart';

class DrawerMenuWidget extends StatelessWidget {
  final ImageModel image;

  DrawerMenuWidget({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            image.imageName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Image.asset(image.imgLink),
          SizedBox(height: 16),
          Text(
            'Priority: ${image.priority}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16),
          Text(
            image.imageDes,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}