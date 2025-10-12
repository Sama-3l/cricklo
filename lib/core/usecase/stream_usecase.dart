import 'package:cricklo/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

class NoParams {}
