import 'package:duan/models/staff.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


class ReadData {
  Future<List<Staff>> loadData() async {
    var data = await rootBundle.loadString("assets/files/userlist.json");
    var dataJson = jsonDecode(data);
    if (dataJson.containsKey("data")) {
      return (dataJson["data"] as List)
          .map((e) => Staff.fromJson(e))
          .toList();
    } else {
      // Xử lý khi không có dữ liệu trong tệp JSON
      return [];
    }
  }
}