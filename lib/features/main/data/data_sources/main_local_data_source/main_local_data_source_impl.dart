import 'dart:io';
import 'dart:math';
import 'package:hive/hive.dart';
import 'main_local_data_source.dart';
import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/fact_entity.dart';

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

  @override
  String? getCatImage() {
    try {
      final box = Hive.box<String>(kCatImageBox);
      if (box.isEmpty) return null;

      final indices = List.generate(box.length, (i) => i)..shuffle();

      for (final index in indices) {
        final path = box.getAt(index);
        if (path != null && File(path).existsSync()) {
          return path;
        }
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
