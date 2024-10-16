import 'dart:convert';

import 'package:chat_web/src/core/utils/base_url.dart';
import 'package:chat_web/src/features/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthDataSource {
  Future<int> createUser(UserModel model);
}

class AuthDataSourceImpl extends AuthDataSource {
  final Dio _dio;

  AuthDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<int> createUser(UserModel model) async {
    try {
      print(model.toJson());
      final Response response = await _dio.post(
        'http://$baseUrl:8000/user',
        data: model.toJson(),
      );

      print("Response: ${response.statusCode}, ${response.statusMessage}, ${response.data}");
      if (response.statusCode == 200) {
        print(jsonDecode(response.data));
        final UserModel result = UserModel.fromJson(jsonDecode(response.data));
        return result.id;
      } else {
        throw Exception('Failed to create user: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
