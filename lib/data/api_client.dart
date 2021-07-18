
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mvvm_demo/utils/app_utils.dart';

class ApiClient{
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal();

  Dio _dio = Dio(BaseOptions(
      baseUrl: AppUtils.BASE_URL,
      connectTimeout: 120000, //2 minute
      receiveTimeout: 180 * 1000, //3 minute
      headers: <String, dynamic>{
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      responseType: ResponseType.json));

  dynamic hitApi(String api,
      {dynamic params, String? accessToken, Options? options}) async {
    if (_dio == null) {
      _dio = Dio();
      // Add options
      _dio
        ..options.baseUrl = AppUtils.BASE_URL
        ..options.connectTimeout = 120000
        ..options.receiveTimeout = 180 * 1000
        ..options.headers = {
          "Content-Type": "application/json",
          "Accept": "application/json"
        };
    }
    _dio.interceptors.clear();
    _dio.interceptors.add(LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true));

    if (accessToken != null) {
      // Add Authorization
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        var customHeaders = {'Authorization': 'Bearer $accessToken'};
        options.headers.addAll(customHeaders);
        return handler.next(options);//changes done on 13/05/2021 18:56
      }));
    }

    try {
      if (params != null) {
        // Post Api
        final response = await _dio.post(api, data: params, options: options);
        return response.data;
      } else {
        // Get Api
        final response = await _dio.get(api);
        return response.data;
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on DioError catch (e) {
      var msg = "";
      bool isUserExist = false;
      int statusCode = 0;
      var data;
      switch (e.type) {
        case DioErrorType.cancel:
          msg = 'Request Cancelled';
          statusCode = 0;
          break;
        case DioErrorType.connectTimeout:
          msg = 'Connection Timeout';
          statusCode = 0;
          break;
        case DioErrorType.receiveTimeout:
          msg = 'Connection Timeout';
          statusCode = 0;
          break;
        case DioErrorType.sendTimeout:
          msg = 'Connection Timeout';
          statusCode = 0;
          break;
        case DioErrorType.other:
          msg = 'No Internet Connection';
          statusCode = 0;
          break;
        case DioErrorType.response:
          switch (e.response?.statusCode) {
            case 302:
            // Bearer Token Missing
              msg = 'Invalid Request';
              statusCode = 302;
              break;
            case 400:
            // Bad Request
              msg = e.response?.data['message'];
              print("400 Bad Request => ${(e.response?.data as Map<String, dynamic>).containsKey("meta") ? e.response?.data["meta"]["is_user_exist"] : false}");
              isUserExist = (e.response?.data as Map<String, dynamic>).containsKey("meta") ? e.response?.data["meta"]["is_user_exist"] : false;
              statusCode = 400;
              data = e.response?.data['data'];
              break;
            case 401:
            // Un Authorized
              msg = e.response?.data['message'];
              statusCode = 401;
              break;
            case 403:
            // Forbidden
              msg = 'Forbidden Error';
              statusCode = 403;
              break;
            case 404:
            // Not Found
              msg = 'Api Not Found';
              statusCode = 404;
              break;
            case 500:
            // Internal Server Error
              msg = 'Server Error';
              statusCode = 500;
              break;
            case 503:
            // Service Unavailable
              msg = 'Service Unavailable';
              statusCode = 503;
              break;
            default:
              msg = 'Something went wrong';
              statusCode = 600;
              break;
          }
          break;
        default:
          msg = 'Something went wrong';
          statusCode = 601;
          break;
      }
    } catch (e) {
      throw Exception('${e.toString()}');
    }
  }


  dynamic getData() async {
    try {
      var data = await hitApi("");
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}