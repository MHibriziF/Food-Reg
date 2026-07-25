import 'package:dio/dio.dart';

const String kGenericErrorMessage = 'Terjadi kesalahan. Silakan coba lagi.';

/// Shown when the device itself has no connectivity.
const String kNoInternetMessage = 'Tidak ada koneksi internet.';

abstract class Failure implements Exception {
  Failure({this.title, this.code, this.message});

  String? title;

  // provide error status code
  String? code;

  /// error message
  String? message;
}

class DioFailure implements Exception {
  DioFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.badResponse:
        message = _handleResponseError(dioError.response!);
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        message = kGenericErrorMessage;
        break;
      case DioExceptionType.transformTimeout:
      default:
        message = kGenericErrorMessage;
        break;
    }
  }

  String message = kGenericErrorMessage;

  String _handleResponseError(Response<dynamic> res) {
    var errorMessage = message;

    final data = res.data;
    if (data is! Map) return errorMessage;

    // FastAPI 422 validation errors: {"detail": [{"loc": [...], "msg": "..."}]}
    final detail = data['detail'];
    if (detail is List && detail.isNotEmpty) {
      final first = detail.first;
      if (first is Map) {
        final loc = (first['loc'] as List?)?.skip(1).join(' → ') ?? '';
        final msg = first['msg']?.toString() ?? '';
        return loc.isNotEmpty ? '$loc: $msg' : msg;
      }
      return detail.toString();
    }

    final error = data['error'];
    if (error is Map) {
      errorMessage = error['message']?.toString() ?? errorMessage;
    } else if (data['message'] != null) {
      errorMessage = data['message'].toString();
    }

    return errorMessage;
  }

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  NetworkFailure({super.code, super.message}) : super(title: 'Network Failure');
}

class NotFoundFailure extends Failure {
  NotFoundFailure({super.code, super.message})
    : super(title: 'Not Found Failure');
}

class BadRequestFailure extends Failure {
  BadRequestFailure({super.code, super.message})
    : super(title: 'Bad Request Failure');
}

class GeneralFailure extends Failure {
  GeneralFailure({super.message}) : super(title: 'General Failure');
}

class TimeoutFailure extends Failure {
  TimeoutFailure({super.message}) : super(title: 'Timeout Failure');
}

class ArgumentFailure extends Failure {
  ArgumentFailure({super.message}) : super(title: 'Argument Failure');
}

class UnAuthorizeFailure extends Failure {
  UnAuthorizeFailure({super.message}) : super(title: 'UnAuthorize Failure');
}

class ParseFailure extends Failure {}

class EmptyFailure extends Failure {}

class CacheFailure extends Failure {
  CacheFailure({super.message}) : super(title: 'Cache Failure');
}
