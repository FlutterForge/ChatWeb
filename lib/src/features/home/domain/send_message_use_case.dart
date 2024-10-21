import 'package:chat_web/src/core/either/either.dart';
import 'package:chat_web/src/core/usecase/usecase.dart';
import 'package:chat_web/src/features/home/data/repository/home_repository.dart';

class SendMessageUseCase extends UseCase<void, List<dynamic>> {
  final HomeRepository _repository;

  SendMessageUseCase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<dynamic, void>> call(List params) {
    return _repository.sendMessage(params[0], params[1]);
  }
}
