// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ExtraClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateAdapter extends TypeAdapter<Extra> {
  @override
  final int typeId = 300;

  @override
  Extra read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Extra(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as int?,
      fields[4] as int?,
      fields[5] as bool?,
      fields[6] as List?,
    );
  }

  @override
  void write(BinaryWriter writer, Extra obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.sort)
      ..writeByte(4)
      ..write(obj.interval)
      ..writeByte(5)
      ..write(obj.superset)
      ..writeByte(6)
      ..write(obj.set);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
