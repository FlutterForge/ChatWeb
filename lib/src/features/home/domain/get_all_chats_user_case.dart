import 'package:chat_web/src/core/either/either.dart';
import 'package:chat_web/src/core/usecase/usecase.dart';
import 'package:chat_web/src/features/auth/data/model/chat_model.dart';
import 'package:chat_web/src/features/home/data/repository/home_repository.dart';

class GetAllChatsUserCase extends UseCase<List<ChatModel>, NoParams> {
  final HomeRepository _repository;

  GetAllChatsUserCase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<dynamic, List<ChatModel>>> call(NoParams params) =>
      _repository.getChats();
}
