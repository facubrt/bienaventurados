// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardados_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GuardadosAdapter extends TypeAdapter<Guardados> {
  @override
  final int typeId = 1;

  @override
  Guardados read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Guardados(
      frase: fields[0] as String?,
      santo: fields[1] as String?,
      reflexion: fields[2] as String?,
      tag: fields[3] as String?,
      fecha: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Guardados obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.frase)
      ..writeByte(1)
      ..write(obj.santo)
      ..writeByte(2)
      ..write(obj.reflexion)
      ..writeByte(3)
      ..write(obj.tag)
      ..writeByte(4)
      ..write(obj.fecha);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuardadosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
