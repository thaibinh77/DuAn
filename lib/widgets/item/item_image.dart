import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemImage extends StatefulWidget {
  const ItemImage({
    Key? key,
    required this.assetPath,
  }) : super(key: key);

  final String assetPath;

  @override
  _ItemImageState createState() => _ItemImageState();
}

class _ItemImageState extends State<ItemImage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Stack(
        children: [
          Image.asset(
            widget.assetPath,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isChecked = !isChecked; // Đảo ngược trạng thái của isChecked khi người dùng nhấp vào
                });
              },
              child: Container(
                width: 20, // Độ rộng của checkbox
                height: 20, // Độ cao của checkbox
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isChecked ? Colors.blue : Colors.transparent,
                  border: Border.all(color: Colors.blue),
                ),
                padding: EdgeInsets.all(5),
                child: isChecked
                    ? Container( // Sử dụng một Container để tạo hình tròn
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
