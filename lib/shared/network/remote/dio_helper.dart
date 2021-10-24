import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,

          /*headers: {
            'Content-Type': 'application/json',
          },*/
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,

  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      'lang': lang,
      'Authorization': token ,

    };
    return await dio.get(

      url,
      queryParameters: query,

    );
  }

  static Future<Response> pastData({
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String lang = 'en',
    String token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      'lang': lang,
      'Authorization': token,
      //"Accept": "application/json"
    };

    return dio.post(url, queryParameters: query, data: data);
  }
}
