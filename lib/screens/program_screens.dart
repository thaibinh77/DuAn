import 'package:duan/models/program.dart';
import 'package:duan/screens/add_program_screen.dart';
import 'package:duan/screens/edit_program_screen.dart';
import 'package:duan/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/api.dart';
import '../data/image_helper.dart';
import '../data/program_helper.dart';
import '../models/image.dart';
import '../resources/app_color.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

import '../widgets/drawer_menu_widget.dart';

class ProgramScreens extends StatefulWidget {
  const ProgramScreens({Key? key}) : super(key: key);

  @override
  State<ProgramScreens> createState() => _ProgramScreensState();
}

class _ProgramScreensState extends State<ProgramScreens> with SingleTickerProviderStateMixin{
  API api = API();
  String _selectedItem = '';
  late List<String> listName = <String>[];
  late List<ImageModel> listImage = <ImageModel>[];
  Program selectedProgram = Program.empty();
  ImageModel selectedImage = ImageModel.empty();

  late SharedPreferences prefs;
  String? role;

  Future<void> _getRole() async {
    prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role');
    setState(() {});
  }

  Future<void> _getProgramByName(String name) async {
    final program = await API().getProgramByName(name);
    setState(() {
      selectedProgram = program;
    });
  }

  Future<void> _getNamePrograms() async {
    listName = await api.getNamePrograms();
    if (listName.isNotEmpty) {
      _selectedItem = listName.first;
      await _getProgramByName(_selectedItem);
      await _getImageByName(_selectedItem);
    }
    setState(() {});
  }

  Future<void> _getImageByName(String name) async {
    listImage = await api.getImageByName(name);
    setState(() {});
  }

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _getNamePrograms();
    _getRole();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1),
    );
    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }


  Future<void> _syncDataFromServer() async {
    try {
      // Lấy danh sách chương trình từ server
      List<Program> programs = await api.getPrograms();

      // Tạo instance của ProgramDatabaseHelper
      ProgramDatabaseHelper programDbHelper = ProgramDatabaseHelper();

      // Lưu chương trình vào SQLite
      for (var program in programs) {
        await programDbHelper.insertProgram(program);
      }

      // Lấy danh sách hình ảnh từ server
      List<ImageModel> images = await api.getImages();

      // Tạo instance của ImageDatabaseHelper
      ImageDatabaseHelper imageDbHelper = ImageDatabaseHelper();

      // Lưu hình ảnh vào SQLite
      for (var image in images) {
        await imageDbHelper.insertImage(image);
      }

      // Hiển thị thông báo thành công
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đồng bộ dữ liệu thành công')),
      );
    } catch (e) {
      // Hiển thị thông báo lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đồng bộ dữ liệu thất bại: $e')),
      );
    }
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Các Chương Trình",
            iconRightButton: Icons.close,
            showBackButton: false,
            onPressedRight: () => SliderWidget(),
          ),
          SizedBox(height: screenSize.height * 0.05),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  // vertical: screenSize.height * 0.02,
                ),
                color: Colors.white,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      listName.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownMenuExample(
                            list: listName,
                            onSelected: (String newValue) async {
                              setState(() {
                                _selectedItem = newValue;
                              });
                              await _getProgramByName(newValue);
                              await _getImageByName(newValue);
                            },
                          ),
                          Text(
                            'Từ ngày: ${Program.getFormattedDate(selectedProgram.startTime)}',
                            style: TextStyle(
                              fontSize: screenSize.width * 0.015,
                              fontWeight: FontWeight.bold,
                              color: AppColors.BaseColorMain,
                            ),
                          ),
                          Text(
                            'Đến ngày: ${Program.getFormattedDate(selectedProgram.endTime)}',
                            style: TextStyle(
                              fontSize: screenSize.width * 0.015,
                              fontWeight: FontWeight.bold,
                              color: AppColors.BaseColorMain,
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: screenSize.height * 0.04),
                      listImage.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : Center(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10.0,
                          ),
                          itemCount: listImage.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImage = listImage[index];
                                });
                                // print(selectedImage);
                                // Mở drawer từ bên phải
                                Scaffold.of(context).openEndDrawer();
                                // Cập nhật thông tin hình ảnh trong drawer

                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(listImage[index].imgLink),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                  Text(
                                    listImage[index].imageName,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.012,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
        endDrawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Header section with image
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  children: [
                    // Display image or placeholder
                    selectedImage.imgLink.isNotEmpty
                        ? Image.asset(
                      selectedImage.imgLink,
                      height: 150, // Adjust height as needed
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Center(child: Text("No Image")),
                    ),
                  ],
                ),
              ),
              // Spacer to push content to the bottom
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                          selectedImage.imageName.isNotEmpty
                              ? selectedImage.imageName
                              : 'No Image Selected',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.0),
                        // Priority
                        Text(
                          'Priority: ${selectedImage.priority ?? 'N/A'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        // Description
                        Text(
                          selectedImage.imageDes.isNotEmpty
                              ? selectedImage.imageDes
                              : 'No Description',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Footer with exit button
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Close the drawer
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ColorButton, // Correct property to set button background color
                    ),
                    child: Text(
                      'Thoát',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionBubble(
          items: <Bubble>[
            Bubble(
              title: "Đồng bộ",
              iconColor: Colors.white,
              bubbleColor: Colors.blue,
              icon: Icons.home,
              titleStyle: TextStyle(fontSize: 16, color: Colors.white),
              onPress: () async {
                _animationController!.reverse();
                await _syncDataFromServer();
                //làm thêm
              },
            ),
            if (role == "admin")
              Bubble(
                title: "Thêm Chương Trình",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.add,
                titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  _animationController.reverse();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProgramScreen()),
                  );
                },
              ),
            if (role == "admin")
              Bubble(
                title: "Chỉnh Sửa",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.edit,
                titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  _animationController.reverse();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProgramScreen(program: selectedProgram, images: listImage,)),
                  );
                },
              ),
          ],
          animation: _animation!,
          onPress: () => _animationController!.isCompleted
              ? _animationController!.reverse()
              : _animationController!.forward(),
          backGroundColor: Colors.blue,
          iconColor: Colors.white,
          iconData: Icons.menu,
        )
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  final List<String> list;
  final Function(String) onSelected;
  const DropdownMenuExample({Key? key, required this.list, required this.onSelected,}) : super(key: key);

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.list.isNotEmpty ? widget.list.first : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: dropdownValue,
      onSelected: (String? value) {
        if (value != null) {
          setState(() {
            dropdownValue = value;
          });
          widget.onSelected(value);
        }
      },
      dropdownMenuEntries: widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
