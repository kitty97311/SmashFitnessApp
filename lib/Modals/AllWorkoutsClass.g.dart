// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllWorkoutsClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreateAdapter extends TypeAdapter<Create> {
  @override
  final int typeId = 200;

  @override
  Create read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Create(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as String?,
      fields[8] as Null,
      fields[9] as String?,
      fields[10] as String?,
      fields[11] as String?,
      fields[12] as Null,
      fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Create obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.repeatCount)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.catName)
      ..writeByte(6)
      ..write(obj.time)
      ..writeByte(7)
      ..write(obj.calories)
      ..writeByte(8)
      ..write(obj.gif)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.isDeleted)
      ..writeByte(12)
      ..write(obj.deletedAt)
      ..writeByte(13)
      ..write(obj.datetime);
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
