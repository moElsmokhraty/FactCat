import '../../domain/entities/fact_entity.dart';

class FactModel extends FactEntity {
  FactModel({required super.fact, required super.length});

  factory FactModel.fromJson(Map<String, dynamic> json) {
    return FactModel(
      fact: json['fact'] as String? ?? '',
      length: json['length'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {'fact': fact, 'length': length};
}

extension FactModelMapper on FactModel {
  FactEntity toEntity() => FactEntity(fact: fact, length: length);
}
