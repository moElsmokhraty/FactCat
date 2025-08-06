import 'package:fact_cat/core/utils/constants.dart';
import 'package:hive_flutter/adapters.dart';
import '../../features/main/domain/entities/fact_entity.dart';

Future<void> setupHiveDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FactEntityAdapter());
  await Hive.openBox<FactEntity>(kFactsBox);
}
