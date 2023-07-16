import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MobileDownloadService implements DownloadService {
  @override
  Future<String> download({required String url}) async {
    // requests permission for downloading the file
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) throw Exception('error.access_denied');

    // gets the directory where we will download the file.
    var dir = await getApplicationDocumentsDirectory();

    String fileName = url.split('/').last;

    final path = "${dir.path}/$fileName";

    // downloads the file
    Dio dio = Dio();
    await dio.download(url, path);

    return path;
  }

  // requests storage permission
  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }
}

sealed class DownloadService {
  Future<String> download({required String url});
}
