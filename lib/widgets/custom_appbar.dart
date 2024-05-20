import 'package:flutter/material.dart';
import 'package:duan/resources/app_color.dart';
import 'package:duan/resources/dimens.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final IconData? iconLeftButton;
  final String? rightButtonImage; // Đường dẫn đến hình ảnh cho nút phải
  final VoidCallback? onPressedRight;
  final VoidCallback? onPressedBack;
  final bool showBackButton;

  const CustomAppBar({
    Key? key,
    this.title,
    this.iconLeftButton,
    this.rightButtonImage,
    this.onPressedRight,
    this.onPressedBack,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimens.MarginTopAppbar),
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
                        color: AppColors.BaseColorBlack,
                        fontSize: Dimens.FontSizeAppBar,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : Container(),
            ),
          ),
          if (rightButtonImage != null) // Kiểm tra nếu có hình ảnh
            GestureDetector(
              onTap: onPressedRight,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Image.asset(
                  rightButtonImage!, // Sử dụng hình ảnh từ đường dẫn
                  width: Dimens.IconSizeAppBar,
                  height: Dimens.IconSizeAppBar,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
