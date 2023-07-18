import 'dart:io';

import 'package:dio/dio.dart';

import '../../../constants/config/monsterapi_config.dart';
import '../../../constants/env/env.dart';
import '../../../constants/env/env_key.dart';
import '../../../constants/urls/api_url.dart';
import '../../../models/post/image_generate_process.dart';
import '../../../models/post/image_generate_task.dart';
import '../../../services/http_service.dart';
import '../../../services/mobile_download_service.dart';
import '../../../utils/exceptions/message_exception.dart';

class GenerateImage {
  HttpService client = HttpService();

  Future<File> request({required String prompt}) async {
    try {
      // initialize Image generator API
      await _init();

      // Generate an Image using prompt
      final task = await _generate(prompt);

      // Wait for result
      final process = await _status(task.processId);
      final outputsUrl = process.responseData.result?.output;

      if (outputsUrl == null || outputsUrl.isEmpty) {
        throw MessageException('error.generate_image_failed');
      }

      // Download and store first output
      return _download(outputsUrl.first);
    } on Exception {
      throw MessageException('error.generate_image_failed');
    }
  }

  Future<void> _init() async {
    // masterApi config
    final masterApiXApiKey = Env.get(EnvKey.masterApiXApiKey);
    final masterApiBearerToken = Env.get(EnvKey.masterApiBearerToken);

    final Map<String, String> header = {
      MonsterapiConfig.xApiKey: masterApiXApiKey,
      MonsterapiConfig.authorization: masterApiBearerToken,
    };

    // initialize HTTP service
    await client.init(ApiUrl.monsterapi, header);
  }

  Future<ImageGenerateTask> _generate(String prompt) async {
    Response response;

    final Map<String, dynamic> date = {
      "model": MonsterapiConfig.model,
      "data": {
        "prompt": "$prompt, 8k, high quality",
        "negprompt": MonsterapiConfig.negativePrompt,
        "samples": MonsterapiConfig.samples,
        "steps": MonsterapiConfig.steps,
        "aspect_ratio": MonsterapiConfig.guidanceScale,
        "guidance_scale": MonsterapiConfig.guidanceScale,
        "seed": MonsterapiConfig.seed,
      }
    };

    response = await client.request(
      url: "/add-task",
      method: Method.POST,
      params: date,
    );

    if (response.statusCode != 200) {
      throw MessageException('error.generate_image_failed');
    }

    return ImageGenerateTask.fromJson(response.data);
  }

  Future<ImageGenerateProcess> _status(String processId) async {
    Response response;

    final Map<String, dynamic> data = {
      "process_id": processId,
    };

    response = await client.request(
      url: "/task-status",
      method: Method.POST,
      params: data,
    );

    if (response.statusCode != 200) {
      throw MessageException('error.failed_to_get_generate_image_status');
    }

    final process = ImageGenerateProcess.fromJson(response.data);
    final status = process.responseData.status;

    if (status == "COMPLETED") {
      return process;
    } else {
      // Call the API again
      // Wait for a certain duration before checking the API status again
      await Future.delayed(const Duration(seconds: 5));
      return _status(processId);
    }
  }

  Future<File> _download(url) async {
    final MobileDownloadService downloadService = MobileDownloadService();
    final file = await downloadService.download(url: url);

    return File(file);
  }
}
