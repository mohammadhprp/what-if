import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'error.cancelBySever';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'error.connectTimeout';
        break;
      case DioExceptionType.unknown:
        message = 'error.server';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'error.receiveTimeout';
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response!.statusCode,
          dioError.response!.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = 'error.sendTimeout';
        break;
      default:
        message = 'error.someThingWentWrong';
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    String? message = error['message']?.toString();

    bool withoutErrorMessage = message == null ||
        message.isNotEmpty ||
        message == 'error.errorMessage';

    return switch (statusCode) {
      400 => withoutErrorMessage ? 'error.e400' : message,
      401 => withoutErrorMessage ? 'error.e401' : message,
      403 => withoutErrorMessage ? 'error.e403' : message,
      404 => withoutErrorMessage ? 'error.e404' : message,
      422 => withoutErrorMessage ? 'error.e422' : message,
      500 => withoutErrorMessage ? 'error.server' : message,
      _ => 'error.someThingWentWrong',
    };
  }

  @override
  String toString() => message;
}
