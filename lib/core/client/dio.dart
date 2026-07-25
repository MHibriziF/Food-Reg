part of '_client.dart';

final _options = Options(
  receiveTimeout: const Duration(seconds: 5),
  sendTimeout: const Duration(seconds: 6),
);

Future<Response<T>> getRequest<T>(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? queryParameters,
}) async {
  final getHeaders = headers ?? HiveService.getHeaders();
  if (kDebugMode) {
    LoggerService.i({'url': url, 'headers': getHeaders});
  }
  final resp = await get<Dio>().get<T>(
    url,
    options: _options.copyWith(headers: getHeaders),
    queryParameters: queryParameters,
  );

  if (kDebugMode) {
    LoggerService.i({
      'response': '${resp.data}',
      'statusCode': '${resp.statusCode}',
    });
  }

  return resp;
}

Future<Response<T>> postRequest<T>(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
  Map<String, dynamic>? queryParameters,
}) async {
  final getHeaders = headers ?? HiveService.getHeaders();
  if (kDebugMode) {
    LoggerService.i({'url': url, 'headers': getHeaders, 'model': '$model'});
  }
  final resp = await get<Dio>().post<T>(
    url,
    data: json.encode(model),
    options: _options.copyWith(headers: getHeaders),
    queryParameters: queryParameters,
  );
  if (kDebugMode) {
    LoggerService.i({
      'response': '${resp.data}',
      'statusCode': '${resp.statusCode}',
    });
  }
  return resp;
}

Future<Response<T>> putRequest<T>(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
  Map<String, dynamic>? queryParameters,
}) async {
  final getHeaders = headers ?? HiveService.getHeaders();
  if (kDebugMode) {
    LoggerService.i({'url': url, 'headers': getHeaders, 'model': '$model'});
  }
  final resp = await get<Dio>().put<T>(
    url,
    data: json.encode(model),
    options: _options.copyWith(headers: getHeaders),
    queryParameters: queryParameters,
  );
  if (kDebugMode) {
    LoggerService.i({
      'response': '${resp.data}',
      'statusCode': '${resp.statusCode}',
    });
  }
  return resp;
}

Future<Response<T>> deleteRequest<T>(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? queryParameters,
}) async {
  final getHeaders = headers ?? HiveService.getHeaders();
  if (kDebugMode) {
    LoggerService.i({
      'url': url,
      'headers': getHeaders,
      'query': '$queryParameters',
    });
  }
  final resp = await get<Dio>().delete<T>(
    url,
    options: _options.copyWith(headers: getHeaders),
    queryParameters: queryParameters,
  );
  if (kDebugMode) {
    LoggerService.i({
      'response': '${resp.data}',
      'statusCode': '${resp.statusCode}',
    });
  }
  return resp;
}

Future<Response<T>> putWithFileRequest<T>(
  String url, {
  Map<String, String>? headers,
  Map<String, dynamic>? model,
  Map<String, dynamic>? queryParameters,
}) async {
  final getHeaders = headers ?? HiveService.getHeaders();

  if (kDebugMode) {
    LoggerService.i({'url': url, 'headers': getHeaders, 'model': '$model'});
  }

  // Convert the model to FormData if it contains a file
  final formData = FormData();

  if (model != null) {
    model.forEach((key, value) {
      if (value is File) {
        formData.files.add(
          MapEntry(
            key,
            MultipartFile.fromFileSync(
              value.path,
              filename: value.path.split('/').last,
            ),
          ),
        );
      } else {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });
  }

  final resp = await get<Dio>().put<T>(
    url,
    data: formData,
    options: _options.copyWith(headers: getHeaders),
    queryParameters: queryParameters,
  );

  if (kDebugMode) {
    LoggerService.i({
      'response': '${resp.data}',
      'statusCode': '${resp.statusCode}',
    });
  }

  return resp;
}
