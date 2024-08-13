class Staff {
  final int id;
  final String name;
  final String role;

  Staff({
    required this.id,
    required this.name,
    required this.role,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'],
      name: json['name'],
      role: json['role'],
    );
  }
}
