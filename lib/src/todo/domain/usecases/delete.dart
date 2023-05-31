import 'package:dartz/dartz.dart';

import '../../../../shared/error/failure.dart';
import '../../../../shared/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class DeleteTodoUseCase implements UseCase<Todo, Params<Todo>> {
  final TodoRepository repository;
  DeleteTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Todo>> call(Params<Todo> params) {
    return repository.delete(params.value);
  }
}
