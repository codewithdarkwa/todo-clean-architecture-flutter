import 'package:dartz/dartz.dart';

import '../../../../shared/error/failure.dart';
import '../../../../shared/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class ListTodoUseCase implements UseCase<Stream<List<Todo>>, NoParams> {
  final TodoRepository repository;
  ListTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<List<Todo>>>> call(NoParams params) {
    return repository.getAll();
  }
}
