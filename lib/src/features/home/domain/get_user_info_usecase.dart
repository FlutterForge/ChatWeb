import 'package:chat_web/src/core/either/either.dart';
import 'package:chat_web/src/core/model/user_model.dart';
import 'package:chat_web/src/core/usecase/usecase.dart';
import 'package:chat_web/src/features/home/data/repository/home_repository.dart';

class GetUserInfoUsecase extends UseCase<UserModel, String> {
  final HomeRepository _repository;

  GetUserInfoUsecase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<dynamic, UserModel>> call(String params) =>
      _repository.getUser(params);
}
