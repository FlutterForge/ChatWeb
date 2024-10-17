import 'dart:convert';

import 'package:chat_web/src/core/extension/print_styles.dart';
import 'package:chat_web/src/core/utils/base_url.dart';
import 'package:chat_web/src/features/auth/data/model/chat_model.dart';
import 'package:chat_web/src/features/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';

abstract class HomeDataSoure {
  Future<UserModel> getUserInfo(String id);
  Future<void> createGroup(ChatModel data);
  Future<List<ChatModel>> getChats();
}

class HomeDataSourceImpl extends HomeDataSoure {
  final Dio _dio;

  static final HomeDataSourceImpl _instance = HomeDataSourceImpl.init(Dio());
  static HomeDataSourceImpl get instance => _instance;
  HomeDataSourceImpl.init(this._dio);

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

  @override
  Future<void> createGroup(ChatModel data) async {
    try {
      final response = await _dio.post(
        "http://$baseUrl:8000/chats",
        data: {
          "name": data.name,
          "chatType": data.chatType,
          "participants": data.participants,
          "link": data.link,
          "messages": data.messages
        },
      );

      if (response.statusCode == 200) {
        print('SUCCESS CREATE CHAT ${response.data}');
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ChatModel>> getChats() async {
    try {
      final response = await _dio.get(
        "http://$baseUrl:8000/chats",
      );

      if (response.statusCode == 200) {
        print('SUCCESS GET CHAT ${response.data}');
        List<ChatModel> data = (json.decode(response.data) as List<dynamic>)
            .map((e) => ChatModel.fromJson(e))
            .toList();

        'AFTER FROM JSON'.printWarning();
        return data;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}
