import 'package:clean_architecture/shared/network/network.dart';
import 'package:clean_architecture/src/todo/todo_injection.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;
void init() {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  initTodo();
}
