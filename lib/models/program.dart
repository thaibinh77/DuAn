import 'package:intl/intl.dart';

class Program {
  final String? id;
  String name;
  String image;
  final DateTime startTime;
  final DateTime endTime;

  Program({
    this.id,
    required this.name,
    required this.image,
    required this.startTime,
    required this.endTime,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      name: json['name'],
      image: json['image'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }

  static String getFormattedDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
