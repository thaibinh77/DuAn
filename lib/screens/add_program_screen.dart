import 'package:duan/screens/program_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../resources/app_color.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/item/item_kho.dart';

class AddProgramScreen extends StatelessWidget {
  const AddProgramScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BodyWidget());
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({Key? key}) : super(key: key);

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
    var screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.05,
        vertical: screenSize.height * 0.02,
      ),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
              title: "Thêm Chương Trình",
              showBackButton: false,
            ),
            SizedBox(height: screenSize.height * 0.07),
            // Đường line và nhập thông tin chương trình
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: screenSize.width * 0.15),
                Text(
                  'Tên Chương trình: ',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.015,
                    fontWeight: FontWeight.bold,
                    color: AppColors.BaseColorBlack,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: screenSize.width * 0.3, // Độ rộng của text field
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.BaseColorBlack,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(fontSize: screenSize.width * 0.015), // Tăng kích thước chữ
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.07),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: screenSize.width * 0.15),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'Từ ngày: ',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.015,
                          fontWeight: FontWeight.bold,
                          color: AppColors.BaseColorMain,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: screenSize.width * 0.1, // Điều chỉnh độ rộng của TextField
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              // handle picked date
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenSize.width * 0.1),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'Đến ngày: ',
                        style: TextStyle(
                          fontSize: screenSize.width * 0.015,
                          fontWeight: FontWeight.bold,
                          color: AppColors.BaseColorMain,
                        ),
                      ),
                      Container(
                        width: screenSize.width * 0.1, // Điều chỉnh độ rộng của TextField
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              // handle picked date
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.04), // Khoảng cách giữa form và hình ảnh
            InkWell(
              onTap: () {
                _openArchive(context);
              },
              child: Image.asset(
                'assets/icons/Add.png',
                width: screenSize.width * 0.1,
                height: screenSize.width * 0.1,
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 45,
                  child: CustomButton(
                    text: "Lưu",
                    moveTo: () => AddProgramScreen(),
                  ),
                ),
                SizedBox(width: screenSize.width * 0.05), // Giảm khoảng cách giữa các button
                SizedBox(
                  width: 200,
                  height: 45,
                  child: CustomButton(text: "Bỏ qua", onPressed: ProgramScreens(),colorBlack: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
