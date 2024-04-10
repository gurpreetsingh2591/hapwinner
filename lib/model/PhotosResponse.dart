class PhotosResponse {
  final String imageurl;

  PhotosResponse({required this.imageurl});

  // Factory method to create a ReminderResponse from a JSON map
  factory PhotosResponse.fromJson(Map<String, dynamic> json) {
    return PhotosResponse(
      imageurl: json['imageurl'] ?? '',

    );
  }
}

class StudentPhotosResponse {
  int status;
  String message;
  List<PhotosResponse> photos;

  StudentPhotosResponse({required this.status, required this.message, required this.photos});

  factory StudentPhotosResponse.fromJson(Map<String, dynamic> json) {
    var result = json['photos'] as List;
    List<PhotosResponse> messages = result.map((messageJson) {
      return PhotosResponse.fromJson(messageJson);
    }).toList();

    return StudentPhotosResponse(
      status: json['status'],
      message: json['message'],
      photos: messages,
    );
  }
}
