import 'package:dartz/dartz.dart';

import '../../../../shared/error/failure.dart';
import '../../../../shared/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repository/todo_repository.dart';

class EditTodoUseCase implements UseCase<Todo, Params<Todo>> {
  final TodoRepository repository;
  EditTodoUseCase(this.repository);

  @override
  Future<Either<Failure, Todo>> call(Params<Todo> params) {
    return repository.edit(params.value);
  }
}
