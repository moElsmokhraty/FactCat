import 'package:dartz/dartz.dart';
import '../../domain/entities/fact_entity.dart';
import '../../../../core/errors/failure.dart';

abstract class MainRepo {
  Future<Either<Failure, FactEntity>> getRandomFact();

  Future<Either<Failure, String>> getCatImage();
}
