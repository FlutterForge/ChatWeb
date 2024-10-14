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
        'http://192.168.0.105:8000/user',
        data: model.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print(
          "Response: ${response.data}, ${response.statusMessage}, ${response.statusCode}");
      if (response.statusCode == 200) {
        print('SUCCESS HERE');
        return response
            .data; // Assuming your API returns a user ID or something similar
      } else {
        throw Exception('Failed to create user: ${response.statusMessage}');
      }
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.connectionError) {
        print('Network error: ${dioError.message}');
      } else {
        print(
            'Dio error: ${dioError.response?.statusMessage}, ${dioError.response?.statusCode}');
      }
      rethrow;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
