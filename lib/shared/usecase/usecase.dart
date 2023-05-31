import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  @override
  List<Object?> get props => [];
}

class Params<Type> {
  final Type value;
  const Params(this.value);
  @override
  List<Object?> get props => [value];
}
