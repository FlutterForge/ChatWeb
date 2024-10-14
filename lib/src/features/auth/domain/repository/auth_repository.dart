import 'package:chat_web/src/core/either/either.dart';
import 'package:chat_web/src/features/auth/data/model/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, int>> createUser(UserModel model);
}
