class Staff {
  final String? id;
  String name;
  String pass;

  Staff({
    this.id,
    required this.name,
    required this.pass,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      name: json['name'],
      pass: json['pass'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pass': pass,
    };
  }
}
