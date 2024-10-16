import 'dart:convert';

import 'package:chat_web/src/core/utils/base_url.dart';
import 'package:chat_web/src/features/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';

abstract class HomeDataSoure {
  Future<UserModel> getUserInfo(String id);
}

class HomeDataSourceImpl extends HomeDataSoure {
  final Dio _dio;

  HomeDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<UserModel> getUserInfo(String id) async {
    try {
      final response = await _dio.get("http://$baseUrl:8000/user/$id");
      if (response.statusCode != null && response.statusCode == 200) {
        print('USER INFO ${response.data}');
        return UserModel.fromJson(json.decode(response.data));
      } else {
        throw Exception(response.statusMessage ?? 'Something went wrong');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout) {
        print('>>>>>DIO EXCEPTION RECIVE TIME OUT ERROR ${e.message}');
      } else if (e.type == DioExceptionType.sendTimeout) {
        print('>>>>>DIO EXCEPTION SEND TIME OUT ERROR ${e.message}');
      } else {
        print('DIO ERROR OCCURED ${e.message}');
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
