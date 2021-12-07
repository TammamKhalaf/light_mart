import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        headers: {
          'Content-Type': 'application/json',
        },
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    String? language,
    String? token,
    required String url,
    Map<String, dynamic>? query}) async {

    dio.options.headers = {
      'lang': '$language',
      'Authorization': token
    };

    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(String language,String token,Map<String,dynamic> query,
      {required String url, required Map<String, dynamic> data}) async {

    dio.options.headers = {
      'lang': '$language',
      'Authorization': token
    };

    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
