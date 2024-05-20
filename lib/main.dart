import 'package:duan/widgets/carousel_widget.dart';
// import 'package:duan/widgets/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CarouselWidget(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Thiết lập màu nền trắng cho toàn bộ ứng dụng
      ),
    );
  }
}
