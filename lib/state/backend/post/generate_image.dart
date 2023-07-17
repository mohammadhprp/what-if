import 'dart:io';

import 'package:dio/dio.dart';

import '../../../constants/env/env.dart';
import '../../../constants/env/env_key.dart';
import '../../../constants/typedefs.dart';
import '../../../models/post/image_generate_process.dart';
import '../../../models/post/image_generate_task.dart';
import '../../../services/http_service.dart';
import '../../../services/mobile_download_service.dart';
import '../../../utils/exceptions/message_exception.dart';

class GenerateImage {
  HttpService client = HttpService();

  IsLoading _isLoading = false;

  IsLoading get isLoading => _isLoading;

  Future<File> request({required String prompt}) async {
    try {
      _isLoading = true;

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
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _init() async {
    // masterApi config
    final masterApiXApiKey = Env.get(EnvKey.masterApiXApiKey);
    final masterApiBearerToken = Env.get(EnvKey.masterApiBearerToken);

    final Map<String, String> header = {
      "x-api-key": masterApiXApiKey,
      "Authorization": masterApiBearerToken,
    };

    // initialize HTTP service
    await client.init('https://api.monsterapi.ai/apis', header);
  }

  Future<ImageGenerateTask> _generate(String text) async {
    Response response;

    final Map<String, dynamic> prompt = {
      "model": "txt2img",
      "data": {
        "prompt": text,
        "negprompt": "lowers, signs, memes, labels, text, food, text,"
            " error, mutant, cropped, worst quality, low quality, "
            "normal quality, jpeg artifacts, signature, watermark, "
            "username, blurry, made by children, caricature, ugly, "
            "boring, sketch, lackluster, repetitive, cropped, "
            "(long neck), facebook, youtube, body horror, out of frame,"
            " mutilated, tiled, frame, border, porcelain skin, doll like,"
            " doll, bad quality, cartoon, lowers, meme, low quality, worst "
            "quality, ugly, disfigured, inhuman",
        "samples": 1,
        "steps": 50,
        "aspect_ratio": "square",
        "guidance_scale": 12.5,
        "seed": 2321
      }
    };

    response = await client.request(
      url: "/add-task",
      method: Method.POST,
      params: prompt,
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
      await Future.delayed(const Duration(seconds: 3));
      return _status(processId);
    }
  }

  Future<File> _download(url) async {
    final MobileDownloadService downloadService = MobileDownloadService();
    final file = await downloadService.download(url: url);

    return File(file);
  }
}
