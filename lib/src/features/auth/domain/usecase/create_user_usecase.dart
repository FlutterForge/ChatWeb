import 'package:chat_web/src/core/either/either.dart';
import 'package:chat_web/src/core/usecase/usecase.dart';
import 'package:chat_web/src/features/auth/domain/repository/auth_repository.dart';

class CreateUserUsecase extends UseCase {
  final AuthRepository _repository;

  CreateUserUsecase({required AuthRepository repository}) : _repository = repository;

  @override
  Future<Either> call(params) => _repository.createUser(params);
}
