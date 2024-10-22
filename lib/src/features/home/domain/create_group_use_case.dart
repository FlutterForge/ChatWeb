import 'package:chat_web/src/core/either/either.dart';
import 'package:chat_web/src/core/model/chat_model.dart';
import 'package:chat_web/src/core/usecase/usecase.dart';
import 'package:chat_web/src/features/home/data/repository/home_repository.dart';

class CreateGroupUseCase extends UseCase<void, ChatModel> {
  final HomeRepository _repository;

  CreateGroupUseCase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<dynamic, void>> call(ChatModel params) async =>
      _repository.createGroup(params);
}
