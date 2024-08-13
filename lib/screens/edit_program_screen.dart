import 'dart:io';
import 'dart:math';

import 'package:duan/screens/program_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../data/api.dart';
import '../models/program.dart';
import '../resources/app_color.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';

class EditProgramScreen extends StatefulWidget {
  final Program program;
  final List<String> images;

  const EditProgramScreen({
    Key? key,
    required this.program,
    required this.images,
  }) : super(key: key);

  @override
  _EditProgramScreenState createState() => _EditProgramScreenState();
}

class _EditProgramScreenState extends State<EditProgramScreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<String> imagesFileList = [];

  API api = API();

  late TextEditingController _nameController;
  late TextEditingController _dateStartController;
  late TextEditingController _dateEndController;

  Future<void> updateProgram() async {
    String name = _nameController.text;
    String startDateStr = _dateStartController.text;
    String endDateStr = _dateEndController.text;

    if (name.isEmpty || startDateStr.isEmpty || endDateStr.isEmpty) {
      _showAddProgramFailDialog("All fields are required.");
      return;
    }
    if (imagesFileList.isEmpty) {
      _showAddProgramFailDialog("Please select images.");
      return;
    }

    DateTime startTime = DateTime.parse(startDateStr);
    DateTime endTime = DateTime.parse(endDateStr);

    if (endTime.isBefore(startTime)) {
      _showAddProgramFailDialog("End date must be after start date.");
      return;
    }

    int numberOfImages = imagesFileList.length - widget.images.length;

    // Save images to local storage and get their paths
    List<String> imagePaths = await _uploadImages(imagesFileList, numberOfImages);

    final res = await api.updateProgram(widget.program.id!, name, startDateStr, endDateStr, imagePaths);

    if (res == "true") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProgramScreens()),
      );
    } else {
      _showAddProgramFailDialog(res);
    }
  }

  Future<List<String>> _uploadImages(List<String> imagesFileList, int numberOfImages) async {
    List<String> imageUrls = ["assets/images/banner1.png", "assets/images/banner2.png", "assets/images/banner3.png", "assets/images/banner4.png", "assets/images/banner5.png", "assets/images/banner6.png"];

    imageUrls.removeWhere((url) => widget.images.contains(url));

    // Create a random number generator
    Random random = Random();

    // Select 3 random images from the list
    List<String> selectedImages = [];
    for (int i = 0; i < numberOfImages; i++) {
      int randomIndex = random.nextInt(imageUrls.length);
      selectedImages.add(imageUrls[randomIndex]);
      imageUrls.removeAt(randomIndex);  // Remove the selected image to avoid duplicates
    }

    selectedImages.addAll(widget.images);
    return selectedImages;
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        imagesFileList.addAll(selectedImages.map((file) => file.path));
      });
    }
  }

  void _showAddProgramFailDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("update program fail"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.program.name);
    _dateStartController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(widget.program.startTime));
    _dateEndController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(widget.program.endTime));
    imagesFileList.addAll(widget.images);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Chỉnh sửa chương trình",
            iconRightButton: Icons.close,
            onPressedRight: () => ProgramScreens(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  // vertical: screenSize.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                            controller: _nameController,
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
                                      setState((){
                                        _dateStartController.text = pickedDate.toString().split(" ")[0];
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
                              Container(
                                width: screenSize.width * 0.1, // Điều chỉnh độ rộng của TextField
                                child: TextField(
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
                                      setState((){
                                        _dateEndController.text = pickedDate.toString().split(" ")[0];
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
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Column(
                    //         children: [
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //             children: [
                    //               Expanded(child: ProgramProviders(showAddImage: true)),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ), // Khoảng cách giữa form và hình ảnh
                    //   ],
                    // ),
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
                                    child: imagesFileList[index].startsWith('assets/')
                                        ? Image.asset(
                                      imagesFileList[index],
                                      fit: BoxFit.cover,
                                    )
                                        : Image.network(
                                      imagesFileList[index],
                                      fit: BoxFit.cover,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  updateProgram();
                                },
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 48)),
                                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFCF2727)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                      side: BorderSide.none,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "LƯU",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: screenSize.width * 0.05),
                          ],
                        ),
                        SizedBox(width: screenSize.width * 0.05), // Giảm khoảng cách giữa các button
                        SizedBox(
                          width: 200,
                          height: 45,
                          child: CustomButton(text: "Bỏ qua", onPressed: ProgramScreens(), colorBlack: true),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
