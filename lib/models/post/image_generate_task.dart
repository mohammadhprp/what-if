import 'dart:convert';

class ImageGenerateTask {
  String message;
  String processId;

  ImageGenerateTask({
    required this.message,
    required this.processId,
  });

  String toRawJson(ImageGenerateTask data) => json.encode(data.toJson());

  factory ImageGenerateTask.fromJson(Map<String, dynamic> json) =>
      ImageGenerateTask(
        message: json["message"],
        processId: json["process_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "process_id": processId,
      };
}
