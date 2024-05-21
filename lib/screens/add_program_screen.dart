import 'dart:io';
import 'package:duan/screens/program_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../resources/app_color.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';

class AddProgramScreen extends StatefulWidget {
  const AddProgramScreen({Key? key}) : super(key: key);

  @override
  _AddProgramScreenState createState() => _AddProgramScreenState();
}

class _AddProgramScreenState extends State<AddProgramScreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imagesFileList = [];

  late TextEditingController _dateStartController;
  late TextEditingController _dateEndController;

  @override
  void initState() {
    super.initState();
    _dateStartController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    _dateEndController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        imagesFileList.addAll(selectedImages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.02,
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(
                title: "Thêm Chương Trình",
                showBackButton: false,
              ),
              SizedBox(height: screenSize.height * 0.07),
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
                    width: screenSize.width * 0.3,
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
                      style: TextStyle(fontSize: screenSize.width * 0.015),
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
                          width: screenSize.width * 0.1,
                          child: TextField(
                            controller: _dateStartController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: _dateStartController.text,
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.parse(_dateStartController.text),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _dateStartController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                });
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
                        SizedBox(width: 10),
                        Container(
                          width: screenSize.width * 0.1,
                          child: TextField(
                            controller: _dateEndController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: _dateEndController.text,
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.parse(_dateEndController.text),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _dateEndController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.04),
              Center(
                child: Container(
                  child: SizedBox(
                    width: screenSize.width * 0.6, // Adjust width as needed
                    height: screenSize.width * 0.105,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6, // Number of columns
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: imagesFileList.length + 1, // +1 for the "Add" button
                      itemBuilder: (context, index) {
                        if (index == imagesFileList.length) {
                          // This is the "Add" button
                          return InkWell(
                            onTap: selectImages,
                            child: Image.asset(
                              'assets/icons/Add.png',
                              width: 200,
                              height: 115,
                            ),
                          );
                        } else {
                          // These are the image items
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0), // Thêm padding xung quanh hình ảnh
                            child: Container(
                              width: 200, // Đặt chiều rộng mong muốn
                              height: 300, // Đặt chiều cao mong muốn để hình ảnh dài ra
                              child: kIsWeb
                                  ? Image.network(
                                imagesFileList[index].path,
                                fit: BoxFit.cover, // Đảm bảo hình ảnh lấp đầy không gian của Container
                              )
                                  : Image.file(
                                File(imagesFileList[index].path),
                                fit: BoxFit.cover, // Đảm bảo hình ảnh lấp đầy không gian của Container
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
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
                  SizedBox(width: screenSize.width * 0.05),
                  SizedBox(
                    width: 200,
                    height: 45,
                    child: CustomButton(
                      text: "Bỏ qua",
                      onPressed: ProgramScreens(),
                      colorBlack: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
