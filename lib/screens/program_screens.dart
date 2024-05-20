import 'package:duan/screens/add_program_screen.dart';
import 'package:duan/screens/edit_program_screen.dart';
import 'package:duan/widgets/carousel_widget.dart';
import 'package:flutter/material.dart';
import '../providers/Program_providers.dart';
import '../resources/app_color.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';

class ProgramScreens extends StatelessWidget {
  const ProgramScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BodyWidget());
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({Key? key}) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(
                  title: "Các Chương Trình",
                  rightButtonImage: "assets/icons/window-close.png",
                  showBackButton: false,
                  onPressedRight: () => CarouselWidget(),
                ),
                SizedBox(height: screenSize.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
                      child: DropdownMenuExample(),
                    ),
                    Text(
                      'Từ ngày: 06/2/2024',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.015,
                        fontWeight: FontWeight.bold,
                        color: AppColors.BaseColorMain,
                      ),
                    ),
                    Text(
                      'Đến ngày: 10/2/2024',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.015,
                        fontWeight: FontWeight.bold,
                        color: AppColors.BaseColorMain,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.04),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: ProgramProvider()),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: ProgramProvider()),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 45,
                      child: CustomButton(
                        text: "Thêm Chương Trình",
                        moveTo: () => AddProgramScreen(),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.05), // Giảm khoảng cách giữa các button
                    SizedBox(
                      width: 200,
                      height: 45,
                      child: CustomButton(
                        text: "Chỉnh Sửa",
                        moveTo: () => EditProgramScreen(),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.05), // Giảm khoảng cách giữa các button
                    SizedBox(
                      width: 200,
                      height: 45,
                      child: CustomButton(text: "Bỏ qua", colorBlack: true),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({Key? key}) : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
