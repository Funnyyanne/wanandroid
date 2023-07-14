import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wanandroid/api/api.dart';
import '../common/log.dart';

class HttpUtil {
  static late HttpUtil instance;
  late Dio dio;
  late BaseOptions options;
  CancelToken cancelToken = CancelToken();

  static HttpUtil getInstance() {
    if (instance == null) {
      HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    options = BaseOptions(
        baseUrl: Api.BASE_URL,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 5),
        headers: {"version": "1.0.0",},
        //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
        contentType: Headers.formUrlEncodedContentType,
        responseType: ResponseType.plain);

    dio = Dio(options);

    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      print('请求之前 header = ${options.headers.toString()}');
      return handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      print('响应之前');
      return handler.next(response);
    }, onError: (DioException e, ErrorInterceptorHandler handler) {
      print('错误之前$e');
      return handler.next(e);
    }));
  }

  get(url, {data, option, cancelToken}) async {
    Response response;
    try {
      response = await dio.get(url,
          queryParameters: data, options: option, cancelToken: cancelToken);
      print('get success --- ${response.statusCode}');
      print('get success---------${response.data}');

      return response;

      // print('get success --- ${response.data}');
    } on DioException catch (e) {
      print('get Error -----$e');
      formatError(e);
    }
  }

  post(url, {data, option, cancelToken}) async {
    late Response response;
    try {
      response = await dio.post(url,
          queryParameters: data, options: option, cancelToken: cancelToken);
      Log.i('get success --- ${response.data}');
      return response;
    } on DioException catch (e) {
      Log.e('post error---------$e');
      formatError(e);
    }
  }

  //download File
  downloadFile(urlPath, savePath) async {
    late Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        Log.i('$count $total');
      });
      Log.i('get success --- ${response.data}');
    } on DioException catch (e) {
      formatError(e);
    }
    return response.data;
  }

  void formatError(DioException exception) {
    if (exception.type == DioExceptionType.connectionTimeout) {
      Log.i('连接超时');
    } else if (exception.type == DioExceptionType.sendTimeout) {
      Log.i('请求超时');
    } else if (exception.type == DioExceptionType.receiveTimeout) {
      Log.i('响应超时');
    } else if (exception.type == DioExceptionType.badResponse) {
      Log.i('出现异常');
    } else if (exception.type == DioExceptionType.cancel) {
      Log.i('请求取消');
    } else {
      Log.i('未知错误');
    }
  }

  void cancelRequest(CancelToken token) {
    token.cancel("canceled");
  }
}
