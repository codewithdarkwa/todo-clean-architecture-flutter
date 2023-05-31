// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import '../../../../shared/error/failure.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repository/todo_repository.dart';
import '../database/todo_remote_database.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDatabase remoteDatabase;
  TodoRepositoryImpl({
    required this.remoteDatabase,
  });

  @override
  Future<Either<Failure, Todo>> add(Todo todo) async {
    try {
      final results = await remoteDatabase.addTodo(todo);
      return Right(results);
    } catch (e) {
      return Left(Failure("Oops, we couldn't add this todo "));
    }
  }

  @override
  Future<Either<Failure, Todo>> delete(Todo todo) async {
    try {
      final results = await remoteDatabase.deleteTodo(todo);
      return Right(results);
    } catch (e) {
      return Left(Failure("Oops, we couldn't delete this todo "));
    }
  }

  @override
  Future<Either<Failure, Todo>> edit(Todo todo) async {
    try {
      final results = await remoteDatabase.editTodo(todo);
      return Right(results);
    } catch (e) {
      return Left(Failure("Oops, we couldn't edit this todo "));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Todo>>>> getAll() async {
    try {
      final results = remoteDatabase.listTodos();
      return Right(results);
    } catch (e) {
      return Left(Failure("Oops, we couldn't fetch todos from the database "));
    }
  }
}
