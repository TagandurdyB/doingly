// ignore_for_file: overridden_fields

import '../../../domain/entities/response_entity.dart';

class ResponseModel extends ResponseEntity {
  @override
  final bool status;
  @override
  final String message;

  ResponseModel({
    required this.status,
    required this.message,
  }) : super(status: false, message: '');

  static ResponseModel get empty =>
      ResponseModel(message: "Empty", status: false);

  factory ResponseModel.frowJson(Map<String, dynamic> json) {
    try {
      return ResponseModel(
        message: json["message"] ?? "null",
        status: json["status"] == "success",
      );
    } catch (err) {
      throw ("Error in ResponseEntity>frowJson : $err");
    }
  }
}
