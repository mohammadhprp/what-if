import 'dart:convert';

ImageGenerateProcess imageGenerateProcessFromJson(String str) =>
    ImageGenerateProcess.fromJson(json.decode(str));

String imageGenerateProcessToJson(ImageGenerateProcess data) =>
    json.encode(data.toJson());

class ImageGenerateProcess {
  String message;
  ResponseData responseData;

  ImageGenerateProcess({
    required this.message,
    required this.responseData,
  });

  factory ImageGenerateProcess.fromJson(Map<String, dynamic> json) =>
      ImageGenerateProcess(
        message: json["message"],
        responseData: ResponseData.fromJson(json["response_data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "response_data": responseData.toJson(),
      };
}

class ResponseData {
  String processId;
  String status;
  Result? result;
  int? creditUsed;
  int? overage;

  ResponseData({
    required this.processId,
    required this.status,
    required this.result,
    required this.creditUsed,
    required this.overage,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        processId: json["process_id"],
        status: json["status"],
        result: json["result"] != null &&
                json["result"] is Map &&
                (json["result"] as Map).isNotEmpty
            ? Result?.fromJson(json["result"])
            : null,
        creditUsed: json["credit_used"],
        overage: json["overage"],
      );

  Map<String, dynamic> toJson() => {
        "process_id": processId,
        "status": status,
        "result": result?.toJson(),
        "credit_used": creditUsed,
        "overage": overage,
      };
}

class Result {
  List<String> output;

  Result({
    required this.output,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        output: List<String>.from(json["output"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "output": List<dynamic>.from(output.map((x) => x)),
      };
}
