// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paperplane_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaperplaneAdapter extends TypeAdapter<Paperplane> {
  @override
  final int typeId = 0;

  @override
  Paperplane read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Paperplane(
      id: fields[0] as String?,
      date: fields[1] as DateTime?,
      quote: fields[2] as String?,
      source: fields[3] as String?,
      inspiration: fields[4] as String?,
      category: fields[5] as String?,
      user: fields[8] as String?,
      background: fields[9] as String?,
      base: fields[10] as String?,
      detail: fields[11] as String?,
      pattern: fields[12] as String?,
      stamp: fields[13] as String?,
      wings: fields[14] as String?,
      likes: fields[15] as int?,
      saved: fields[16] as bool?,
      views: fields[17] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Paperplane obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.quote)
      ..writeByte(3)
      ..write(obj.source)
      ..writeByte(4)
      ..write(obj.inspiration)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.user)
      ..writeByte(9)
      ..write(obj.background)
      ..writeByte(10)
      ..write(obj.base)
      ..writeByte(11)
      ..write(obj.detail)
      ..writeByte(12)
      ..write(obj.pattern)
      ..writeByte(13)
      ..write(obj.stamp)
      ..writeByte(14)
      ..write(obj.wings)
      ..writeByte(15)
      ..write(obj.likes)
      ..writeByte(16)
      ..write(obj.saved)
      ..writeByte(17)
      ..write(obj.views);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaperplaneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
