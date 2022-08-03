import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json',
        'lang': 'en',
      },
    ));
  }

  static Future<Response> getData(
      { String url,  Map<String, dynamic> query,lang,token}) async {
    ///TODo: this bloc of code is unSuccess
    dio.options.headers = {
      'lang': lang,
      'Authorization': token??null,
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      { url, query,  data, lang = 'ar', token}) async {
    ///TODo: this bloc of code is unSuccess
    dio.options.headers = {
      'lang': lang,
    'Authorization': token??null,
    };
    return await dio.post(url, queryParameters: query, data: data);
  }
}
