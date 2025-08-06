import 'package:hive/hive.dart';
import '../../features/main/domain/entities/fact_entity.dart';
import '../utils/constants.dart';

Future<void> cacheRandomFact(FactEntity fact) async {
  var box = Hive.box<FactEntity>(kFactsBox);
  await box.add(fact);
}
