import 'package:intl/intl.dart';

class Program {
  final int? id;
  String name;
  final DateTime startTime;
  final DateTime endTime;

  Program.empty()
      : id = 0,
        name = '',
        startTime = DateTime.now(),
        endTime = DateTime.now();

  Program({
    this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['programId'],
      name: json['programName'],
      startTime: DateTime.parse(json['startDate']),
      endTime: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'programId': id,
      'programName': name,
      'startDate': startTime.toIso8601String(),
      'endDate': endTime.toIso8601String(),
    };
  }

  static String getFormattedDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
      id: map['imageId'],
      name: map['programName'],
      startTime: DateTime.parse(map['startDate']),
      endTime: DateTime.parse(map['endDate']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageId': id,
      'programName': name,
      'startDate': startTime.toIso8601String(),
      'endDate': endTime.toIso8601String(),
    };
  }
}
