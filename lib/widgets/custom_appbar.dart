import 'package:flutter/material.dart';
import 'package:duan/resources/app_color.dart';
import 'package:duan/resources/dimens.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final IconData? iconLeftButton;
  final IconData? iconRightButton; // Đường dẫn đến hình ảnh cho nút phải
  final Widget Function()? onPressedRight;
  final Widget Function()? onPressedBack;
  final bool showBackButton;

  const CustomAppBar({
    Key? key,
    this.title,
    this.iconLeftButton,
    this.iconRightButton,
    this.onPressedRight,
    this.onPressedBack,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.02,
      ),
      color: Color(0xFF004559), // Màu nền của thanh AppBar
      child: Row(
        children: [
          if (showBackButton)
            IconButton(
              icon: Icon(iconLeftButton ?? Icons.arrow_back),
              onPressed: onPressedBack ?? () => Navigator.of(context).pop(),
            ),
          SizedBox(width: 16), // Khoảng cách giữa nút và tiêu đề
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: title != null
                  ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title!,
                      style: const TextStyle(
                        color: AppColors.BaseColorWhite,
                        fontSize: Dimens.FontSizeAppBar,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : Container(),
            ),
          ),
          if (iconRightButton != null) // Kiểm tra nếu có hình ảnh
            GestureDetector(
              onTap: () {
                if (onPressedRight != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => onPressedRight!()),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Icon(
                  iconRightButton,
                  color: AppColors.BaseColorWhite,
                  size: 32,
                ))
            ),
        ],
      ),
    );
  }
}
