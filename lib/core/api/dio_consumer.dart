import 'dart:convert';
import 'dart:io';
import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:vzadi/core/api/status_code.dart';

import '../error/Exceptions.dart';
import 'api_consumer.dart';
import 'app_interceptors.dart';
import 'end_points.dart';
import 'package:vzadi/injection_container.dart' as di;


class DioConsumer implements ApiConsumer{
  final Dio client;
  DioConsumer({required this.client}){
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
  };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(di.sl<AppInterceptors>());
    /// i do this check because i need to use the loginInterceptor in debug mode only
    if(kDebugMode){
      client.interceptors.add(di.sl<LogInterceptor>());
    }
}

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters})async {
    try {
      final response = await client.get(
          path, queryParameters: queryParameters);
      return _handelResponseAsJson(response);
    } on DioException catch(exception){
      _handlerDioException(exception);
    }
  }

  @override
  Future post(String path, {Map<String, dynamic>? body,bool formDataIsEnabled = false, Map<String, dynamic>? queryParameters}) async{
    try {
      final response = await client.post(
          path, queryParameters: queryParameters, data: formDataIsEnabled ? FormData.fromMap(body!):body);
      return _handelResponseAsJson(response);
    } on DioException catch(exception){
      _handlerDioException(exception);
    }
  }

  @override
  Future patch(String path, {Map<String, dynamic>? body,bool formDataIsEnabled = false, Map<String, dynamic>? queryParameters})async{
    try {
      final response = await client.patch(
          path, queryParameters: queryParameters, data: formDataIsEnabled ? FormData.fromMap(body!):body);
      return _handelResponseAsJson(response);
    } on DioException catch(exception){
      _handlerDioException(exception);
    }
  }

  @override
  Future put(String path, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async{
    try {
      final response = await client.put(
          path, queryParameters: queryParameters, data: body);
      return _handelResponseAsJson(response);
    } on DioException catch(exception){
      _handlerDioException(exception);
    }
  }
  @override
  Future delete(String path, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters})async{
    try {
      final response = await client.delete(
          path, queryParameters: queryParameters);
      return _handelResponseAsJson(response);
    } on DioException catch(exception){
      _handlerDioException(exception);
    }
  }

  dynamic _handelResponseAsJson(Response<dynamic> response){
    final responseJson=jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handlerDioException(DioException exception){
    switch(exception.type){
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badResponse:
        switch(exception.response?.statusCode){
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unAuthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflect:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        throw const NoInternetConnectionException();
      case DioExceptionType.badCertificate:
        throw const NoInternetConnectionException();
      default:
        break;
    }
  }




}