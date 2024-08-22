// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomWorkoutsClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkOutAdapter extends TypeAdapter<WorkOut> {
  @override
  final int typeId = 178;

  @override
  WorkOut read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkOut(
      list: (fields[5] as List).cast<Create>(),
      extraList: fields[6] as List,
      intervelTime: fields[2] as String,
      retpeatWorkOut: fields[3] as String,
      totalCal: fields[1] as String,
      totalTime: fields[0] as String,
      name: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkOut obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.totalTime)
      ..writeByte(1)
      ..write(obj.totalCal)
      ..writeByte(2)
      ..write(obj.intervelTime)
      ..writeByte(3)
      ..write(obj.retpeatWorkOut)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.list)
      ..writeByte(6)
      ..write(obj.extraList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkOutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
