import 'package:chat_web/src/core/either/either.dart';
import 'package:chat_web/src/core/model/user_model.dart';
import 'package:chat_web/src/core/usecase/usecase.dart';
import 'package:chat_web/src/features/auth/data/repository/auth_repository_impl.dart';

class CreateUserUsecase extends UseCase<List, UserModel> {
  final AuthRepository _repository;

  CreateUserUsecase({required AuthRepository repository}) : _repository = repository;

  @override
  Future<Either<String, List>> call(UserModel params) => _repository.createUser(params);
}
