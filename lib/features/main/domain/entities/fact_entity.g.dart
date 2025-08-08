// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fact_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FactEntityAdapter extends TypeAdapter<FactEntity> {
  @override
  final int typeId = 0;

  @override
  FactEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FactEntity(
      fact: fields[0] as String,
      length: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FactEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.fact)
      ..writeByte(1)
      ..write(obj.length);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FactEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
