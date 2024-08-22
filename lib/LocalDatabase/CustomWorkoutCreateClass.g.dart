// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomWorkoutCreateClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomWorkoutCreateClassAdapter
    extends TypeAdapter<CustomWorkoutCreateClass> {
  @override
  final int typeId = 3;

  @override
  CustomWorkoutCreateClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomWorkoutCreateClass(
      id: fields[0] as String,
      name: fields[1] as String,
      image: fields[2] as String,
      repeatCount: fields[3] as String,
      url: fields[4] as String,
      catName: fields[5] as String,
      time: fields[6] as String,
      calories: fields[7] as String,
      gif: fields[8] as String,
      createdAt: fields[9] as String,
      updatedAt: fields[10] as String,
      isDeleted: fields[11] as String,
      deletedAt: fields[12] as String,
      datetime: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustomWorkoutCreateClass obj) {
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
      other is CustomWorkoutCreateClassAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
