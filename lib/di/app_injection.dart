import 'package:base_flutter_app/data/prefs/app_preference.dart';
import 'package:base_flutter_app/data/remote/remote_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class AppInjection {
  void map() {
    final Injector injector = Injector.getInjector();
    injector.map<AppPreferences>((i) => AppPreferences(), isSingleton: true);
    injector.map<RemoteSource>((i) => RemoteSource(_getDio()), isSingleton: true);
  }

  //== dio ==
  Dio _getDio() {
    Dio dio = new Dio();

    dio.options.baseUrl = "https://us-central1-base-flutter-app-67d0a.cloudfunctions.net";
    dio.options.connectTimeout = 10000; //5s
    dio.options.receiveTimeout = 10000;

    // logging
    String prefix = "== Dio";
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        print("$prefix --> ${options.method} ${options.baseUrl}${options.path}");
        print("$prefix ${options.headers.toString()}");
        print("$prefix ${options.data.toString()}");
        return options;
      },
      onResponse: (Response response) {
        print("$prefix <-- ${response.statusCode.toString()} END ${response.request.method} ${response.request.baseUrl}${response.request.path}");
        print("$prefix ${response.headers.toString()}");
        print("$prefix ${response.data.toString()}");
        return response;
      },
      onError: (DioError e) {
        print("$prefix <-- ERROR ${e.request.method} ${e.request.baseUrl}${e.request.path}");
        print(prefix + " " + e.toString());
        return e;
      }
    ));

    return dio;
  }
}