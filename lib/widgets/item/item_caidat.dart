import 'package:flutter/material.dart';

import '../../screens/program_screens.dart';
import '../custom_button.dart';
import 'item_caidat.dart';
import 'item_caidatapi.dart';

class SettingDiaglog extends StatefulWidget {
  const SettingDiaglog({
    Key? key
  }) : super(key: key);

  @override
  _SettingDiaglogState createState() => _SettingDiaglogState();
}

class _SettingDiaglogState extends State<SettingDiaglog> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start, // Đặt crossAxisAlignment là start
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              "Vui lòng trọn cài đặt / \n Đồng bộ hình ảnh & Video",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset(
              "assets/icons/window-close.png",
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 50), // Padding cho nội dung dialog
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3, // Độ rộng của nội dung dialog
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              text: "CÀI ĐẶT",
              moveTo: () => SettingAPI(),
            ),
            SizedBox(width: 80), // Khoảng cách giữa hai button
            CustomButton(
              text: "ĐỒNG BỘ",
              onPressed: ProgramScreens(),
              colorBlack: true
            ),
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Bo góc dialog
      ),
    );
  }
}
