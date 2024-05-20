import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../resources/app_color.dart';
import '../../screens/driver_screen.dart';
class ArchiveDialog extends StatefulWidget {
  const ArchiveDialog({Key? key}) : super(key: key);

  @override
  _ArchiveDialogState createState() => _ArchiveDialogState();
}

class _ArchiveDialogState extends State<ArchiveDialog> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: Text(
              "Kho lưu trữ hình ảnh/video",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 50),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.3,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.02),
                      child: DropdownMenuExample(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
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
  String? selectedValue;

  List<String> items = <String>[
    'Từ thiết bị',
    'Từ USB',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 40,
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/file.png',
              width: 16,
              height: 16,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                'Chọn các tệp',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.BaseColorBlack,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 4),
            VerticalDivider(
              color: AppColors.BaseColorGrey,
              thickness: 1,
              width: 16,
            ),
          ],
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  item == 'Từ USB' ? 'assets/icons/usb.png' : 'assets/icons/device.png',
                  width: 16,
                  height: 16,
                ),
                SizedBox(width: 10),
                Text(item),
              ],
            ),
          );
        }).toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
            if (selectedValue == 'Từ USB') {
              // Chuyển hướng đến trang DriverScreen khi chọn "Từ USB"
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DriverScreens()),
              );
            }
            else if(selectedValue == 'Từ thiết bị'){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DriverScreens()),
              );
            }
          });
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9),
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: AppColors.BaseColorBlack,
            size: 24,
          ),
          openMenuIcon: Icon(Icons.keyboard_arrow_up_outlined, size: 24,
            color: AppColors.BaseColorBlack,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
        underline: Container(),
      ),
    );
  }
}
