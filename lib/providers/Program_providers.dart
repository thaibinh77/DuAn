import 'package:flutter/material.dart';

import '../widgets/item/item_kho.dart';

const List<String> list = <String>[
  'Chương trình 1',
  'Chương trình 2',
  'Chương trình 3'
];

class ProgramProvider extends StatelessWidget {
  final bool showAddImage;

  const ProgramProvider({Key? key, this.showAddImage = false}) : super(key: key);

  void _openArchive(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ArchiveDialog();
      },
    );
  }

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
          if (showAddImage)
            InkWell(
              onTap: () {
                _openArchive(context);
              },
              child: Image.asset(
                'assets/icons/Add.png',
                width: 200, // Kích thước của hình ảnh
                height: 115, // Kích thước của hình ảnh
              ),
            ),
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
