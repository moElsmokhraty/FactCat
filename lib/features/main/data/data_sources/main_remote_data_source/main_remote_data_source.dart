import '../../../domain/entities/fact_entity.dart';

abstract class MainRemoteDataSource {
  Future<FactEntity> fetchRandomFact();
}
