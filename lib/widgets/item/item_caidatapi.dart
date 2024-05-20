import 'package:flutter/material.dart';

import '../custom_button.dart';
import 'item_caidat.dart';

class SettingAPI extends StatefulWidget {
  const SettingAPI({
    Key? key
  }) : super(key: key);

  @override
  _SettingAPIState createState() => _SettingAPIState();
}

class _SettingAPIState extends State<SettingAPI> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              "THIẾT LẬP",
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
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Chỉ dành cho quản trị viên',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/icons/Rest API.png",
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    Text('Thiết lập API', textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize:18 ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextInput(
                  controller: _usernameController,
                  hint: '',
                ),
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
              text: "LƯU",
              moveTo: () => SettingDiaglog(),
            ),
            SizedBox(width: 80), // Khoảng cách giữa hai button
            CustomButton(text: "BỎ QUA", colorBlack: true),
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Bo góc dialog
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  //final String label;
  final String hint;
  final bool obscureText;

  const TextInput({
    required this.controller,
    //required this.label,
    required this.hint,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          //labelText: label,
          hintText: hint,
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0), // Bo góc khung input
          ),
        ),
      ),
    );
  }
}
