import 'package:hive/hive.dart';

part 'fact_entity.g.dart';

@HiveType(typeId: 0)
class FactEntity extends HiveObject {
  @HiveField(0)
  String fact;
  @HiveField(1)
  int length;

  FactEntity({required this.fact, required this.length});
}
