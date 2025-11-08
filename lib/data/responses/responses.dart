import '../../app/enums.dart';

class BasicResponse {
  final String status;
  final String message;

  BasicResponse({
    required this.status,
    required this.message,
  });

  factory BasicResponse.fromJson(Map<String, dynamic> json) {
    return BasicResponse(
      status: (json['status'] as String?) ?? "success",
      message: (json['message'] as String?) ?? "",
    );
  }
}