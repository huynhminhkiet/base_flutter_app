import 'package:dio/dio.dart';

class RemoteSource {
  final Dio _dio;

  const RemoteSource(this._dio);

  Future<Response> testRequest() {
    return _dio.get("/helloWorld");
  }

}