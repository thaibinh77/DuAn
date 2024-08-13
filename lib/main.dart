import 'package:duan/widgets/slider_widget.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:duan/widgets/test.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyBnUleVtQ2epuXR_wm9zcapsF8GYuk1LFw",
        projectId: "duanpos-47532",
        messagingSenderId: "264695332764",
        appId: "1:264695332764:web:25f6e6af150e2ad71ed259",
        measurementId: "G-J9ZV1DBV9Z",
        storageBucket:"duanpos-47532.appspot.com"
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SliderWidget(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Thiết lập màu nền trắng cho toàn bộ ứng dụng
      ),
    );
  }
}
