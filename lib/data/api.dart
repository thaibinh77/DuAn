import 'dart:convert';

import 'package:duan/models/program.dart';
import 'package:http/http.dart' as http;

import '../models/image.dart';


class API {
  String baseUrl = "https://localhost:7240/api/Program";

  Future<List<Program>> getPrograms() async {
    List<Program> data = [];

    final uri = Uri.parse('$baseUrl/GetAllPrograms');
    try {
      final res = await http.get(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
      );
      if(res.statusCode == 200){
        final List<dynamic> jsonData = json.decode(res.body);
        data = jsonData.map((json) => Program.fromJson(json)).toList();
      }
      return data;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<ImageModel>> getImages() async {
    List<ImageModel> data = [];

    final uri = Uri.parse('$baseUrl/GetAllImages');
    try {
      final res = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if(res.statusCode == 200){
        final List<dynamic> jsonData = json.decode(res.body);
        data = jsonData.map((json) => ImageModel.fromJson(json)).toList();
      }
      return data;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<String>> getNamePrograms() async {
    List<String> data = [];

    final uri = Uri.parse('$baseUrl/GetAllNamePrograms');

    try {
      final res = await http.get(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
      );
      if(res.statusCode == 200){
        final List<dynamic> jsonData = json.decode(res.body);
        data = jsonData.cast<String>();
      }
      return data;
    } catch (ex) {
      rethrow;
    }
  }

  // Future<Program> getProgramById(Program program) async {
  //   try {
  //     final body = FormData.fromMap({
  //       'id': program.id
  //     });
  //     Response res = await api.sendRequest.get(
  //         '/GetProgramById');
  //     return res.data
  //         .map((e) => Program.fromJson(e))
  //         .cast<Program>();
  //   } catch (ex) {
  //     rethrow;
  //   }
  // }

  Future<Program> getProgramByName(String name) async {
    Program? data;

    final uri = Uri.parse('$baseUrl/GetProgramByName/$name');

    try {
      final res = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if(res.statusCode == 200){
        final Map<String, dynamic> jsonData = json.decode(res.body);
        data = Program.fromJson(jsonData);
      }
      return data!;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<String>> getImageByName(String name) async {
    List<String> data = [];

    final uri = Uri.parse('$baseUrl/GetImageByName/$name');

    try {
      final res = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      if(res.statusCode == 200){
        final List<dynamic> jsonData = json.decode(res.body);
        data = jsonData.cast<String>();
      }
      return data;
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> addProgram(
      String name, String startTime, String endTime, List<String> imagePaths) async {

    final uri = Uri.parse('$baseUrl/CreateProgram');

    try {
      final body = json.encode({
        "programName": name,
        "startDate": startTime,
        "endDate": endTime,
        "images": imagePaths.map((path) => {"imgLink": path}).toList(),
      });
      final res = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: body,
      );
      if (res.statusCode == 200) {
        return "true";
      } else {
        print("Failed with status code: ${res.statusCode}, body: ${res.body}");
        return "false";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> updateProgram(int programId, String name, String startTime, String endTime, List<String> imagePaths) async {
    final uri = Uri.parse('$baseUrl/UpdateProgram');

    try {
      final body = json.encode({
        'programId': programId,
        'programName': name,
        'startDate': startTime,
        'endDate': endTime,
        "images": imagePaths.map((path) => {"imgLink": path}).toList(),
      });
      final res = await http.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: body,
      );
      if (res.statusCode == 200) {
        print("success");
        return "true";
      } else {
        print("Failed with status code: ${res.statusCode}, body: ${res.body}");
        return "false";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
}
