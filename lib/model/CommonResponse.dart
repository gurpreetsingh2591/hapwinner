

class CommonResponse {
  dynamic status;
  String message;


  CommonResponse({required this.status, required this.message, });

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}