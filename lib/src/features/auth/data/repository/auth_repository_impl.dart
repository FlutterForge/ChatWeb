import 'package:chat_web/src/core/either/either.dart';
import 'package:chat_web/src/features/auth/data/data_source/auth_data_source.dart';
import 'package:chat_web/src/features/auth/data/model/user_model.dart';
import 'package:chat_web/src/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl({required AuthDataSource dataSource}) : _dataSource = dataSource;
  @override
  Future<Either<String, int>> createUser(UserModel model) async {
    try {
      final int uid = await _dataSource.createUser(model);
      return Right(uid);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
