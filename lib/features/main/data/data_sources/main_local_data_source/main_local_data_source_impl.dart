import 'dart:math';
import 'package:hive/hive.dart';

import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/fact_entity.dart';
import 'main_local_data_source.dart';

class MainLocalDataSourceImpl implements MainLocalDataSource {
  MainLocalDataSourceImpl();

  @override
  FactEntity? getRandomFact() {
    var box = Hive.box<FactEntity>(kFactsBox);
    List<FactEntity> allFacts = box.values.toList();
    if (allFacts.isEmpty) return null;

    final randomFact = allFacts[Random().nextInt(allFacts.length)];
    return randomFact;
  }
}
