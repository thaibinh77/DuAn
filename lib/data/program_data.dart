import 'package:flutter/services.dart';
import 'dart:convert';
import '../models/program.dart';


class ReadData {
  Future<List<Program>> loadData() async {
    var data = await rootBundle.loadString("assets/files/programlist.json");
    var dataJson = jsonDecode(data);
    return (dataJson["data"] as List)
        .map((e) => Program.fromJson(e))
        . toList();

  }
}