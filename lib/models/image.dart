
class ImageModel {
  final int? id;
  final String imgLink;
  final int programId;

  ImageModel.empty()
      : id = 0,
        programId = 0,
        imgLink = '';

  ImageModel({
    this.id,
    required this.programId,
    required this.imgLink,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['imageId'],
      programId: json['programId'],
      imgLink: json['imgLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageId': id,
      'programId': programId,
      'imgLink': imgLink,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['imageId'],
      programId: map['programId'],
      imgLink: map['imgLink'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageId': id,
      'programId': programId,
      'imgLink': imgLink,
    };
  }
}
