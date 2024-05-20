import 'package:duan/providers/Driver_provider.dart';
import 'package:duan/screens/add_program_screen.dart';
import 'package:duan/screens/edit_program_screen.dart';
import 'package:flutter/material.dart';
import '../providers/Program_providers.dart';
import '../resources/app_color.dart';
import '../resources/dimens.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';

class DriverScreens extends StatelessWidget {
  const DriverScreens({Key? key}) : super(key: key);

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
                  title: "Kho Hình Ảnh/Video",
                  showBackButton: false,
                ),
                SizedBox(height: screenSize.height * 0.05),
                SizedBox(height: screenSize.height * 0.04),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: DriverProvider()),
                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: DriverProvider()),
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
                        text: "Lưu",
                        moveTo: () => AddProgramScreen(),
                      ),
                    ),
                    SizedBox(width: screenSize.width * 0.05),
                    SizedBox(
                      width: 200,
                      height: 45,
                      child: CustomButton(text: "Bỏ qua",colorBlack: true),
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


