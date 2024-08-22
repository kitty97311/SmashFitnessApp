// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HabitClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitClassAdapter extends TypeAdapter<HabitClass> {
  @override
  final int typeId = 101;

  @override
  HabitClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitClass()
      ..startDate = fields[0] as String?
      ..days = fields[1] as String?
      ..completed = fields[2] as String?
      ..id = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, HabitClass obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.startDate)
      ..writeByte(1)
      ..write(obj.days)
      ..writeByte(2)
      ..write(obj.completed)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
