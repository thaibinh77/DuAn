class ImageModel {
  final int? id;
  final String imgLink;
  final int programId;
  final String imageName;
  final int priority;
  final String imageDes;

  ImageModel.empty()
      : id = 0,
        programId = 0,
        imgLink = '',
        imageName = '',
        priority = 0,
        imageDes = '';

  ImageModel({
    this.id,
    required this.programId,
    required this.imgLink,
    required this.imageName,
    required this.priority,
    required this.imageDes,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['imageId'],
      programId: json['programId'],
      imgLink: json['imgLink'],
      imageName: json['imageName'],
      priority: json['priority'],
      imageDes: json['imageDes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageId': id,
      'programId': programId,
      'imgLink': imgLink,
      'imageName': imageName,
      'priority': priority,
      'imageDes': imageDes,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['imageId'],
      programId: map['programId'],
      imgLink: map['imgLink'],
      imageName: map['imageName'],
      priority: map['priority'],
      imageDes: map['imageDes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageId': id,
      'programId': programId,
      'imgLink': imgLink,
      'imageName': imageName,
      'priority': priority,
      'imageDes': imageDes,
    };
  }
}
