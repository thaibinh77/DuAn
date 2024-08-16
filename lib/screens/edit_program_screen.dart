import 'dart:io';
import 'dart:math';

import 'package:duan/screens/program_screens.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../data/api.dart';
import '../models/image.dart';
import '../models/program.dart';
import '../resources/app_color.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';

class EditProgramScreen extends StatefulWidget {
  final Program program;
  final List<ImageModel> images;

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
  List<ImageModel> imageModels = [];
  Uint8List imageWeb = Uint8List(8);
  File? imageFile;
  String imageLink = '';

  API api = API();

  late TextEditingController _nameController;
  late TextEditingController _dateStartController;
  late TextEditingController _dateEndController;
  TextEditingController _imageNameController = TextEditingController();
  TextEditingController _priorityController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  Future<void> updateProgram() async {
    String name = _nameController.text;
    String startDateStr = _dateStartController.text;
    String endDateStr = _dateEndController.text;

    if (name.isEmpty || startDateStr.isEmpty || endDateStr.isEmpty) {
      _showAddProgramFailDialog("Update program fail", "All fields are required.");
      return;
    }

    DateTime startTime = DateTime.parse(startDateStr);
    DateTime endTime = DateTime.parse(endDateStr);

    if (endTime.isBefore(startTime)) {
      _showAddProgramFailDialog("Update program fail", "End date must be after start date.");
      return;
    }


    final res = await api.updateProgram(widget.program.id!, name, startDateStr, endDateStr, imageModels);

    if (res == "true") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProgramScreens()),
      );
    } else {
      _showAddProgramFailDialog("Add program fail", res);
    }
  }

  // Future<List<String>> _uploadImages(List<String> imagesFileList, int numberOfImages) async {
  //   List<String> imageUrls = ["assets/images/banner1.png", "assets/images/banner2.png", "assets/images/banner3.png", "assets/images/banner4.png", "assets/images/banner5.png", "assets/images/banner6.png"];
  //
  //   imageUrls.removeWhere((url) => widget.images.contains(url));
  //
  //   // Create a random number generator
  //   Random random = Random();
  //
  //   // Select 3 random images from the list
  //   List<String> selectedImages = [];
  //   for (int i = 0; i < numberOfImages; i++) {
  //     int randomIndex = random.nextInt(imageUrls.length);
  //     selectedImages.add(imageUrls[randomIndex]);
  //     imageUrls.removeAt(randomIndex);  // Remove the selected image to avoid duplicates
  //   }
  //
  //   selectedImages.addAll(widget.images.imgLink);
  //   return selectedImages;
  // }

  Future<String> saveImage() async {
    List<String> imageUrls = ["assets/images/banner1.png", "assets/images/banner2.png", "assets/images/banner3.png", "assets/images/banner4.png", "assets/images/banner5.png", "assets/images/banner6.png"];

    imageUrls.removeWhere((url) => imageModels.contains(url));

    // Create a random number generator
    Random random = Random();

    int randomIndex = random.nextInt(imageUrls.length);
    String selectedImages = imageUrls[randomIndex];

    return selectedImages;
  }

  void selectImage() async {
    if(!kIsWeb){
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selectedImage = File(image.path);
        setState(() {
          imageFile = selectedImage;
        });
      } else{

      }
    } else if(kIsWeb){
      FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles();

      if(filePickerResult != null){
        setState(() {
          imageLink = filePickerResult.files.first.name;
          imageWeb = filePickerResult.files.first.bytes!;
          imageFile = File(imageLink);
        });
      }
    } else {
      print('Something went wrong');
    }
    print("Link: " + imageLink);
  }

  Future<void> _saveImageInfo() async {
    if (imageFile == null) {
      _showAddProgramFailDialog("Add program fail", "Please add image");
      return;
    }

    String imageName = _imageNameController.text;
    int priority = int.tryParse(_priorityController.text) ?? 0;
    String imageDes = _notesController.text;

    String imageFileLink = imageFile.toString();
    String imageWebLink = imageWeb.toString();

    if (imageName.isEmpty || priority == null || imageDes.isEmpty) {
      _showAddProgramFailDialog("Add image fail", "All fields are required.");
      return;
    }

    if (imageFileLink.isEmpty || imageWebLink.isEmpty) {
      _showAddProgramFailDialog("Add image fail", "Please select image.");
      return;
    }

    imageLink = await saveImage();

    if (imageLink == '') {
      _showAddProgramFailDialog("Add image fail", "Cannot download image.");
      return;
    }

    setState(() {
      imageModels.add(ImageModel(
        id: 0,
        imgLink: imageLink,
        // Assuming you want to use the file path as the link
        programId: widget.program.id!,
        // Set appropriate value for programId
        imageName: imageName,
        priority: priority,
        imageDes: imageDes,
      ));

      _imageNameController.clear();
      _priorityController.clear();
      _notesController.clear();
      imageFile = null;
    });
  }

  void _showAddProgramFailDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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
    imageModels.addAll(widget.images);
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
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Text(
                                'Tên Chương trình: ',
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.015,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.BaseColorBlack,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft, // Align the container to the left
                                  child: Container(
                                    width: screenSize.width * 0.25, // Adjust this value to make the underline shorter
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: AppColors.BaseColorBlack,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        hintText: '',
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      style: TextStyle(fontSize: screenSize.width * 0.015),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: screenSize.width * 0.05),
                        Expanded(
                          flex: 1,
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
                              Expanded(
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
                                      initialDate: DateTime.now(),
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
                        SizedBox(width: screenSize.width * 0.075),
                        Expanded(
                          flex: 1,
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
                              Expanded(
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
                                      initialDate: DateTime.now(),
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
                    SizedBox(height: screenSize.height * 0.075),
                    Container(
                      padding: EdgeInsets.all(30.0), // Padding inside the container
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.BaseColorBlack, // Border color
                          width: 2.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(4.0), // Border radius
                        color: Colors.white, // Background color
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // "Thêm hình" button placed on the top right
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              width: 150,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  _saveImageInfo();
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFB0B0B0)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: BorderSide.none,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  "Thêm hình",
                                  style: TextStyle(
                                    fontSize: screenSize.width * 0.012,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20), // Space between button and content
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image display and upload section
                              imageFile == null
                                  ? InkWell(
                                onTap: selectImage,
                                child: Image.asset(
                                  'assets/icons/Add.png',
                                  width: screenSize.width * 0.35,
                                  height: screenSize.height * 0.45,
                                ),
                              )
                                  : GestureDetector(
                                onTap: selectImage,
                                child: Container(
                                  width: screenSize.width * 0.35,
                                  height: screenSize.height * 0.45,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: kIsWeb ? MemoryImage(imageWeb) : FileImage(imageFile!),
                                      fit: BoxFit.fill,
                                    ),
                                    border: Border.all(color: Colors.black, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(Icons.edit, color: Colors.grey, size: 40),
                                  ),
                                ),
                              ),
                              SizedBox(width: 30), // Space between image and text fields
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          // Image name field
                                          Text(
                                            'Tên hình:',
                                            style: TextStyle(
                                              fontSize: screenSize.width * 0.012,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            width: screenSize.width * 0.15,
                                            child: TextField(
                                              controller: _imageNameController, // Gán controller ở đây
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppColors.BaseColorBlack,
                                                    width: 2.0, // Độ dày của gạch chân
                                                  ),
                                                ),
                                                hintText: '', // Thay thế nếu cần
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenSize.height * 0.075, width: screenSize.width * 0.05,), // Space between rows
                                      Row(
                                        children: [
                                          // Priority field
                                          Text(
                                            'Độ ưu tiên:',
                                            style: TextStyle(
                                              fontSize: screenSize.width * 0.012,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            width: screenSize.width * 0.05,
                                            child: TextField(
                                              controller: _priorityController, // Gán controller ở đây
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppColors.BaseColorBlack,
                                                    width: 2.0, // Underline thickness
                                                  ),
                                                ),
                                                hintText: '',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenSize.height * 0.075), // Space between rows
                                  // Notes field
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ghi chú:',
                                        style: TextStyle(
                                          fontSize: screenSize.width * 0.012,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        width: screenSize.width * 0.4, // Adjust the width if needed
                                        child: TextField(
                                          controller: _notesController, // Gán controller ở đây
                                          maxLines: 5, // Allow multiple lines
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: '',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.05),
                    SizedBox(
                      height: 200, // Adjust the height as needed
                      child: ListView.builder(
                        itemCount: imageModels.length,
                        itemBuilder: (context, index) {
                          return _buildCard(imageModels[index]);
                        },
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

  Widget _buildCard(ImageModel image) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white, // Màu nền trắng cho Card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: image.imgLink != null && image.imgLink.isNotEmpty
                    ? DecorationImage(
                  image: AssetImage(image.imgLink),
                  fit: BoxFit.cover,
                )
                    : null,
                color: Colors.grey[200], // Màu nền khi không có ảnh
              ),
              child: image.imgLink == null || image.imgLink.isEmpty
                  ? Center(
                child: Icon(
                  Icons.image,
                  size: 60,
                  color: Colors.grey,
                ),
              )
                  : null,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    image.imageName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    NumberFormat('#').format(image.priority),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    image.imageDes,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
