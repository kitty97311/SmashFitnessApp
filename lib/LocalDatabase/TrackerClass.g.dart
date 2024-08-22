// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TrackerClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackerClassAdapter extends TypeAdapter<TrackerClass> {
  @override
  final int typeId = 102;

  @override
  TrackerClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrackerClass()
      ..date = fields[0] as String?
      ..cups = fields[1] as String?
      ..drink = fields[2] as String?
      ..steps = fields[3] as String?
      ..walk = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, TrackerClass obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.cups)
      ..writeByte(2)
      ..write(obj.drink)
      ..writeByte(3)
      ..write(obj.steps)
      ..writeByte(4)
      ..write(obj.walk);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackerClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
