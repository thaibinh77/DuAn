import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/user_data.dart';
import '../../models/staff.dart';
import '../custom_button.dart';
import 'item_caidat.dart';

class LoginDialog extends StatefulWidget {

  const LoginDialog({
    Key? key,
  }) : super(key: key);

  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  List<Staff> listStaff = [];
  final TextEditingController _usernameController = TextEditingController();
  bool isLoading = true;

  Future<void> loadListStaff() async {
    listStaff = await ReadData().loadData();
    setState(() {
      isLoading = false; // Dữ liệu đã được tải
    });
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    loadListStaff();
  }

  void _login() async {
    String username = _usernameController.text;

    // Kiểm tra xem tài khoản có tồn tại trong danh sách hay không
    bool accountExists = listStaff.any((account) => username == account.name);

    if (accountExists) {
      Staff? account = listStaff.firstWhere((account) => username == account.name);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('role', account.role);

      String? role = prefs.getString('role');
      print("role of user is: $role");

      // Thực hiện các hành động tiếp theo sau khi đăng nhập thành công
      Navigator.of(context).pop(); // Đóng dialog sau khi đăng nhập thành công
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SettingDiaglog(); // Thêm ! để bỏ qua null safety
        },
      );
    } else {
      // Hiển thị thông báo lỗi khi tài khoản không tồn tại
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Lỗi"),
            content: Text("Tài khoản không tồn tại."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng hộp thoại
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              "ĐĂNG NHẬP",
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
                    Text("Vui lòng nhập mã nhân viên", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10),
                TextInput(
                  controller: _usernameController,
                  hint: 'Nhập mã nhân viên',
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
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _login();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 48)), // Kích thước tối thiểu của button
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)), // Khoảng cách giữa nội dung và biên
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFCF2727)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: BorderSide.none, // Đường viền màu đen
                    ),
                  ),
                ),
                child: Text(
                  "Xác nhận",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 80), // Khoảng cách giữa hai button
            CustomButton(text: "Bỏ qua", colorBlack: true),
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
