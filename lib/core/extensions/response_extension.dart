part of '_extensions.dart';

class Parsed<T> {
  Parsed.fromJson(Map<String, dynamic> json, this.statusCode, this.data) {
    final error = json['error'];
    message =
        (error is Map ? error['message'] as String? : error as String?) ??
        json['detail'] as String? ??
        json['message'] as String? ??
        '';
  }

  Parsed.fromDynamicData(this.statusCode, this.data);

  late int statusCode;
  late String message;
  late T data;
}

extension ResponseExtension on Response<dynamic> {
  Parsed<T> parse<T>(T t) {
    return Parsed.fromJson(data as Map<String, dynamic>, statusCode!, t);
  }

  Parsed<T> parseDynamicData<T>(T t) {
    return Parsed.fromDynamicData(statusCode!, t);
  }

  List<dynamic> get dataAsList => data['data'] as List<dynamic>;

  Map<String, dynamic> get dataAsMap => data['data'] as Map<String, dynamic>;
}
