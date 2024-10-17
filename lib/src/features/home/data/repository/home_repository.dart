import 'package:chat_web/src/core/either/either.dart';
import 'package:chat_web/src/features/auth/data/model/chat_model.dart';
import 'package:chat_web/src/features/auth/data/model/user_model.dart';
import 'package:chat_web/src/features/home/data/data_source/home_data_soure.dart';

abstract class HomeRepository {
  Future<Either<String, UserModel>> getUser(String id);
  Future<Either<String, void>> createGroup(ChatModel data);
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSoure _dataSoure;

  HomeRepositoryImpl({required HomeDataSoure dataSoure})
      : _dataSoure = dataSoure;

  @override
  Future<Either<String, UserModel>> getUser(String id) async {
    try {
      final result = await _dataSoure.getUserInfo(id);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> createGroup(ChatModel data) async {
    try {
      final result = await _dataSoure.createGroup(data);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
