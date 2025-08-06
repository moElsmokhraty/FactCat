import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

abstract class UseCase<Type> {
  const UseCase();

  Future<Either<Failure, Type>> call();
}
