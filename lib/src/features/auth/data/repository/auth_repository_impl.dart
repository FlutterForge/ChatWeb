import 'package:chat_web/src/core/either/either.dart';
import 'package:chat_web/src/core/model/user_model.dart';
import 'package:chat_web/src/features/auth/data/data_source/auth_data_source.dart';

abstract class AuthRepository {
  Future<Either<String, List>> createUser(UserModel model);
}


class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl({required AuthDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<Either<String, List>> createUser(UserModel model) async {
    try {
      final result = await _dataSource.createUser(model);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
