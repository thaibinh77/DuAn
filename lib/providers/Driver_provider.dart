import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/item/item_image.dart';

class DriverProvider extends StatefulWidget {

  const DriverProvider({Key? key}) : super(key: key);

  @override
  _DriverProviderState createState() => _DriverProviderState();
}

class _DriverProviderState extends State<DriverProvider> {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 25.0, // Khoảng cách giữa các ảnh
      runSpacing: 10.0, // Khoảng cách giữa các dòng
      children: [
        ItemImage(assetPath: "assets/images/banner1.png"),
        ItemImage(assetPath: "assets/images/banner2.png"),
        ItemImage(assetPath: "assets/images/banner3.png"),
        ItemImage(assetPath: "assets/images/banner4.png"),
        ItemImage(assetPath: "assets/images/banner5.png"),
        ItemImage(assetPath: "assets/images/banner6.png"),
      ],
    );
  }
}
