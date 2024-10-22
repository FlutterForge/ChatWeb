import 'dart:convert';

import 'package:chat_web/src/core/model/user_model.dart';
import 'package:chat_web/src/core/utils/base_url.dart';
import 'package:dio/dio.dart';

abstract class AuthDataSource {
  Future<List> createUser(UserModel model);
}

class AuthDataSourceImpl extends AuthDataSource {
  final Dio _dio;

  AuthDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List> createUser(UserModel model) async {
    try {
      print(model.toJson());
      final Response response = await _dio.post(
        'http://$baseUrl:8000/user',
        data: model.toJson(),
      );

      final UserModel result = UserModel.fromJson(jsonDecode(response.data)['data']);
      if (response.statusCode == 200) {
        return [
          result,
          true
        ];
      } else if (response.statusCode == 202) {
        return [
          result,
          false
        ];
      } else {
        throw Exception('Failed to create user: ${response.statusMessage}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
