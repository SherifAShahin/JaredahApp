import 'package:dio/dio.dart';

// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=747e7ba538494b3caed96dc703efef31

class DioHelper {
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
  required String url,
  required Map<String, dynamic> query,
}) async
  {
    return await dio.get(
      url,
      queryParameters: query
    );
  }
}