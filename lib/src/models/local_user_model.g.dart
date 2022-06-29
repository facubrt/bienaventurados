// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalUserAdapter extends TypeAdapter<LocalUser> {
  @override
  final int typeId = 3;

  @override
  LocalUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalUser(
      uid: fields[0] as String?,
      username: fields[1] as String?,
      email: fields[2] as String?,
      role: fields[3] as String?,
      img: fields[4] as String?,
      type: fields[5] as String?,
      level: fields[6] as int?,
      totalXP: fields[7] as int?,
      action: fields[8] as int?,
      formation: fields[9] as int?,
      devotion: fields[10] as int?,
      prayer: fields[11] as int?,
      pplanesBuilded: fields[12] as int?,
      pplanesShared: fields[13] as int?,
      constancy: fields[14] as int?,
      bestConstancy: fields[15] as int?,
      firstConnection: fields[16] as String?,
      lastConnection: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalUser obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.img)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.level)
      ..writeByte(7)
      ..write(obj.totalXP)
      ..writeByte(8)
      ..write(obj.action)
      ..writeByte(9)
      ..write(obj.formation)
      ..writeByte(10)
      ..write(obj.devotion)
      ..writeByte(11)
      ..write(obj.prayer)
      ..writeByte(12)
      ..write(obj.pplanesBuilded)
      ..writeByte(13)
      ..write(obj.pplanesShared)
      ..writeByte(14)
      ..write(obj.constancy)
      ..writeByte(15)
      ..write(obj.bestConstancy)
      ..writeByte(16)
      ..write(obj.firstConnection)
      ..writeByte(17)
      ..write(obj.lastConnection);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
