// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture/src/todo/domain/entities/todo.dart';
import 'package:clean_architecture/src/todo/domain/usecases/delete.dart';
import 'package:dartz/dartz.dart';

import '../../../../shared/error/failure.dart';
import '../../../../shared/usecase/usecase.dart';
import '../../domain/usecases/add.dart';
import '../../domain/usecases/edit.dart';
import '../../domain/usecases/list.dart';

class TodoBloc {
  final AddTodoUseCase addTodo;
  final EditTodoUseCase editTodo;
  final DeleteTodoUseCase deleteTodo;
  final ListTodoUseCase listTodo;
  TodoBloc({
    required this.addTodo,
    required this.editTodo,
    required this.deleteTodo,
    required this.listTodo,
  });

  Future<Either<Failure, Todo>> add(Todo todo) async {
    final response = await addTodo(Params(todo));
    return response;
  }

  Future<Either<Failure, Todo>> edit(Todo todo) async {
    final response = await editTodo(Params(todo));
    return response;
  }

  Future<Either<Failure, Todo>> delete(Todo todo) async {
    final response = await deleteTodo(Params(todo));
    return response;
  }

  Stream<List<Todo>> list() async* {
    final response = await listTodo(NoParams());
    yield* response.fold((failure) async* {
      [Todo.initial()];
    }, (todo) async* {
      yield* todo;
    });
  }
}
