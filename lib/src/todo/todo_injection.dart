import 'package:clean_architecture/src/todo/presentation/bloc/todo_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/database/todo_remote_database.dart';
import 'data/repository/todo_repository_impl.dart';
import 'domain/repository/todo_repository.dart';
import 'domain/usecases/add.dart';
import 'domain/usecases/delete.dart';
import 'domain/usecases/edit.dart';
import 'domain/usecases/list.dart';

void initTodo() {
  final sl = GetIt.instance;

  sl

    ///register database
    ..registerLazySingleton<TodoRemoteDatabase>(
      () => TodoRemoteDatabaseImpl(),
    )

    ///register Todo repository
    ..registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(remoteDatabase: sl()),
    )

    /// register UseCases
    ..registerLazySingleton<AddTodoUseCase>(() => AddTodoUseCase(sl()))
    ..registerLazySingleton<DeleteTodoUseCase>(() => DeleteTodoUseCase(sl()))
    ..registerLazySingleton<EditTodoUseCase>(() => EditTodoUseCase(sl()))
    ..registerLazySingleton<ListTodoUseCase>(() => ListTodoUseCase(sl()))

    /// register Bloc
    ..registerFactory<TodoBloc>(
      () => TodoBloc(
        addTodo: sl(),
        deleteTodo: sl(),
        editTodo: sl(),
        listTodo: sl(),
      ),
    );
}
