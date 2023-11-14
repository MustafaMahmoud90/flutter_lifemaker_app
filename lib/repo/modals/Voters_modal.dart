// ignore_for_file: file_names

class VotersModal {
  int? id;
  int? vote;
  String? image;
  String? name;
  String? details;

  VotersModal({this.id, this.vote, this.image, this.name, this.details});

  VotersModal.fromJson({required Map<String, dynamic> data}) {
    id = data['id'].toInt();
    vote = data['vote'];
    image = data['image_url'] ?? 'assets/user.jpg';
    name = data['name'].toString();
    details = data['details'].toString();
  }
}

class ImageData {
  String? image;
  String? name;
  String? description;

  ImageData({this.image, this.name, this.description});

  ImageData.fromJson({required Map<String, dynamic> data}) {
    image = data['image_url'] ?? 'assets/user.jpg';
    name = data['name'].toString();
    description = data['description'].toString();
  }
}
