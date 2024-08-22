// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProgressClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgressClassAdapter extends TypeAdapter<ProgressClass> {
  @override
  final int typeId = 1;

  @override
  ProgressClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressClass()
      ..calories = fields[0] as String?
      ..workOuts = fields[1] as String?
      ..seconds = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, ProgressClass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.calories)
      ..writeByte(1)
      ..write(obj.workOuts)
      ..writeByte(2)
      ..write(obj.seconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
