import '../../../domain/entities/fact_entity.dart';

abstract class MainLocalDataSource {
  FactEntity? getRandomFact();
}
