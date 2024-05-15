import 'package:flutter/material.dart';

const List<String> list = <String>[
  'Chương trình 1',
  'Chương trình 2',
  'Chương trình 3'
];

class ProgramProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 30.0, // Khoảng cách giữa các ảnh
        runSpacing: 10.0, // Khoảng cách giữa các dòng
        children: [
          _buildImage("assets/images/banner1.png"),
          _buildImage("assets/images/banner2.png"),
          _buildImage("assets/images/banner3.png"),
          _buildImage("assets/images/banner4.png"),
          _buildImage("assets/images/banner5.png"),
          _buildImage("assets/images/banner6.png"),
        ],
    );
  }

  Widget _buildImage(String assetPath) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
      ),
    );
  }
}
