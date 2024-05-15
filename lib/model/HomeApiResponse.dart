
class HomeApiResponse<T> {
  final int status;
  final String message;
  final T data;

  HomeApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeApiResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) dataParser) {
    return HomeApiResponse(
      status: json['status'],
      message: json['message'],
      data: dataParser(json['data']),
    );
  }
}
