// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avioncito_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AvioncitoAdapter extends TypeAdapter<Avioncito> {
  @override
  final int typeId = 0;

  @override
  Avioncito read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Avioncito(
      id: fields[0] as String?,
      frase: fields[1] as String?,
      santo: fields[2] as String?,
      reflexion: fields[3] as String?,
      tag: fields[4] as String?,
      usuario: fields[5] as String?,
      guardado: fields[6] as bool?,
      visto: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Avioncito obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.frase)
      ..writeByte(2)
      ..write(obj.santo)
      ..writeByte(3)
      ..write(obj.reflexion)
      ..writeByte(4)
      ..write(obj.tag)
      ..writeByte(5)
      ..write(obj.usuario)
      ..writeByte(6)
      ..write(obj.guardado)
      ..writeByte(7)
      ..write(obj.visto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvioncitoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
