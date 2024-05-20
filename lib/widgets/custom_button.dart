import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.moveTo,
    this.colorBlack = false,
  }) : super(key: key);

  final Widget? onPressed;
  final String text;
  final Widget Function()? moveTo; // Function có thể là null
  final bool colorBlack;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          if (moveTo != null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return moveTo!(); // Thêm ! để bỏ qua null safety
              },
            );
          }
          else if (onPressed != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => onPressed!),
            );
          }
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 48)), // Kích thước tối thiểu của button
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)), // Khoảng cách giữa nội dung và biên
          backgroundColor: colorBlack == false ? MaterialStateProperty.all<Color>(const Color(0xFFCF2727)) : MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: colorBlack == false ? BorderSide.none : const BorderSide(color: Colors.black), // Đường viền màu đen
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorBlack == false ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
