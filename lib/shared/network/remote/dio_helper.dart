import 'package:dio/dio.dart';
import 'package:news_app/shared/components/constants/constants.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {required String url, required Map<String, dynamic> queryParameters}) async {
    return await dio!.get(url, queryParameters: queryParameters);
  }

  static Future<Response> searchForNews(String value) async {
    return await dio!.get('v2/everything', queryParameters: {'q': value, 'apiKey': kNewsApiKey});
  }
}
